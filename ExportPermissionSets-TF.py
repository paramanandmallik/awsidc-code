import boto3
import json
import re

# Initialize boto3 clients
#Salted Credentials


try:
       session = boto3.Session()
       sso_admin_client = session.client('sso-admin')
       identity_store_client = session.client('identitystore')

except Exception as e:
        print(f"Error getting connection: {e}")

# Set your Identity Center instance ARN and Identity Store ID
IDENTITY_CENTER_INSTANCE_ARN = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
IDENTITY_STORE_ID = "d-dddgdsg"

# Function to list all users and map their names to PrincipalId
def get_user_map():
    user_map = {}
    response = identity_store_client.list_users(
        IdentityStoreId=IDENTITY_STORE_ID
    )
    for user in response['Users']:
        user_map[user['UserId']] = user['UserName']
    return user_map

# Function to list all groups and map their names to PrincipalId
def get_group_map():
    group_map = {}
    response = identity_store_client.list_groups(
        IdentityStoreId=IDENTITY_STORE_ID
    )
    for group in response['Groups']:
        group_map[group['GroupId']] = group['DisplayName']
    return group_map

# Function to list accounts for a provisioned permission set
def list_accounts_for_permission_set(permission_set_arn):
    response = sso_admin_client.list_accounts_for_provisioned_permission_set(
        InstanceArn=IDENTITY_CENTER_INSTANCE_ARN,
        PermissionSetArn=permission_set_arn
    )
    return response['AccountIds']

# Function to list assignments for a permission set
def list_account_assignments(permission_set_arn, account_id):
    response = sso_admin_client.list_account_assignments(
        InstanceArn=IDENTITY_CENTER_INSTANCE_ARN,
        AccountId=account_id,
        PermissionSetArn=permission_set_arn
    )
    return response['AccountAssignments']

# Function to sanitize resource names
def sanitize_resource_name(name):
    return re.sub(r'[^a-zA-Z0-9]', '', name)[:40]  # Limit name to 40 characters and remove non-alphanumeric characters

# Get user and group maps
user_map = get_user_map()
group_map = get_group_map()

# Write user and group maps to backup files
with open('user_map.json', 'w') as user_file:
    json.dump(user_map, user_file, indent=2)

with open('group_map.json', 'w') as group_file:
    json.dump(group_map, group_file, indent=2)

# List all permission sets
permission_sets = sso_admin_client.list_permission_sets(
    InstanceArn=IDENTITY_CENTER_INSTANCE_ARN
)['PermissionSets']

# Initialize CloudFormation template structure
cloudformation_template = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {}
}

# Loop through each permission set
for permission_set_arn in permission_sets:
    # List accounts for the permission set
    account_ids = list_accounts_for_permission_set(permission_set_arn)

    # Loop through each account and add assignments to CloudFormation template
    for account_id in account_ids:
        assignments = list_account_assignments(permission_set_arn, account_id)
        for assignment in assignments:
            principal_id = assignment['PrincipalId']
            principal_type = assignment['PrincipalType']

            # Get the name from the appropriate map
            if principal_type == 'USER':
                principal_name = user_map.get(principal_id, principal_id)
            elif principal_type == 'GROUP':
                principal_name = group_map.get(principal_id, principal_id)
            else:
                principal_name = principal_id

            permission_set_name = sanitize_resource_name(permission_set_arn.split('/')[-1])
            resource_name = f"Assignment{permission_set_name}{account_id}{sanitize_resource_name(principal_name)}"

            cloudformation_template["Resources"][resource_name] = {
                "Type": "AWS::SSO::Assignment",
                "Properties": {
                    "InstanceArn": IDENTITY_CENTER_INSTANCE_ARN,
                    "PermissionSetArn": permission_set_arn,
                    "PrincipalId": principal_id,
                    "PrincipalType": principal_type,
                    "TargetId": account_id,
                    "TargetType": "AWS_ACCOUNT"
                }
            }

# Write the CloudFormation template to a file
with open('permission_set_assignments.json', 'w') as cf_file:
    json.dump(cloudformation_template, cf_file, indent=2)

print("CloudFormation template generation completed. Output written to permission_set_assignments.json")
print("User and group maps written to user_map.json and group_map.json")
