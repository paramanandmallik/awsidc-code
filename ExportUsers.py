import boto3
import json

# Replace with your actual AWS credentials and Identity Store ID

IDENTITY_STORE_ID = 'd-sgddg'


# Initialize the boto3 client for Identity Center with AWS credentials
client = boto3.client('sso-admin')

def list_identity_store_users(identity_store_id):
    users = []
    paginator = client.get_paginator('list_users')
    for page in paginator.paginate(IdentityStoreId=identity_store_id):
        users.extend(page['Users'])
    return users

def list_identity_store_groups(identity_store_id):
    groups = []
    paginator = client.get_paginator('list_groups')
    for page in paginator.paginate(IdentityStoreId=identity_store_id):
        groups.extend(page['Groups'])
    return groups

def list_group_memberships(identity_store_id, group_id):
    memberships = []
    paginator = client.get_paginator('list_group_memberships')
    for page in paginator.paginate(IdentityStoreId=identity_store_id, GroupId=group_id):
        memberships.extend(page['GroupMemberships'])
    return memberships

def convert_to_azure_format(users, groups):
    azure_users = []
    azure_groups = []

    for user in users:
        azure_user = {
            "userPrincipalName": user['UserName'],
            "displayName": user['DisplayName'],
            "mail": user.get('Email', ''),
            "givenName": user.get('GivenName', ''),
            "surname": user.get('FamilyName', '')
        }
        azure_users.append(azure_user)

    for group in groups:
        azure_group = {
            "displayName": group['DisplayName'],
            "members": []
        }
        memberships = list_group_memberships(IDENTITY_STORE_ID, group['GroupId'])
        for membership in memberships:
            member_id = membership['MemberId']
            member_user = next((u for u in users if u['UserId'] == member_id), None)
            if member_user:
                azure_group['members'].append(member_user['UserName'])
        azure_groups.append(azure_group)

    return {
        "Users": azure_users,
        "Groups": azure_groups
    }

def main():
    # Get users and groups
    users = list_identity_store_users(IDENTITY_STORE_ID)
    groups = list_identity_store_groups(IDENTITY_STORE_ID)

    # Convert to Azure format
    azure_data = convert_to_azure_format(users, groups)

    # Export to JSON
    with open('azure_identity_center_data.json', 'w') as f:
        json.dump(azure_data, f, indent=4)

    print("Data exported successfully to azure_identity_center_data.json")

if __name__ == "__main__":
    main()
