#!/bin/bash

# Ensure jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Please install it to run this script."
    exit
fi

# Set the AWS profile to use
export AWS_PROFILE=param

# Prompt for the AWS IAM Identity Center instance ARN if not provided as argument
if [ $# -eq 0 ]; then
    read -p "Enter the AWS IAM Identity Center instance ARN: " INSTANCE_ARN
else
    INSTANCE_ARN=$1
fi

# Validate INSTANCE_ARN
if [ -z "$INSTANCE_ARN" ]; then
    echo "Instance ARN is required. Please provide it."
    exit 1
fi

# Create a temporary JSON file to hold the data
TEMP_JSON_FILE=$(mktemp)

# Initialize the JSON structure
echo "[]" > $TEMP_JSON_FILE

# Get the list of permission sets
PERMISSION_SETS=$(aws sso-admin list-permission-sets --instance-arn $INSTANCE_ARN --query 'PermissionSets' --output text)

for PERMISSION_SET_ARN in $PERMISSION_SETS; do
    echo "Processing Permission Set ARN: $PERMISSION_SET_ARN"

    # Get the list of accounts for each permission set
    ACCOUNTS=$(aws sso-admin list-accounts-for-provisioned-permission-set --instance-arn $INSTANCE_ARN --permission-set-arn $PERMISSION_SET_ARN --query 'AccountIds' --output text)

    for ACCOUNT_ID in $ACCOUNTS; do
        echo "  Processing Account ID: $ACCOUNT_ID"

        # Get the list of assignments for each permission set and account
        ASSIGNMENTS=$(aws sso-admin list-account-assignments --instance-arn $INSTANCE_ARN --account-id $ACCOUNT_ID --permission-set-arn $PERMISSION_SET_ARN --query 'AccountAssignments' --output json)

        # Append the data to the temporary JSON file
        jq --argjson assignments "$ASSIGNMENTS" --arg permSetArn "$PERMISSION_SET_ARN" --arg accountId "$ACCOUNT_ID" \
           '. += [{"PermissionSetArn": $permSetArn, "AccountId": $accountId, "Assignments": $assignments}]' $TEMP_JSON_FILE > $TEMP_JSON_FILE.tmp && mv $TEMP_JSON_FILE.tmp $TEMP_JSON_FILE
    done
done

# Convert the structured JSON to YAML using jq
jq -r 'map({PermissionSetArn, AccountId, Assignments})' $TEMP_JSON_FILE > backup.yaml

# Clean up the temporary JSON file
rm $TEMP_JSON_FILE

echo "Backup completed. The data has been saved to backup.yaml"

