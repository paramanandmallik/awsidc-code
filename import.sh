#!/bin/bash

# Define AWS SSO profile name
SSO_PROFILE="param"

# AWS CLI command to list IAM permission sets
PERMISSION_SETS=$(aws sso-admin list-permission-sets --profile $SSO_PROFILE --query "PermissionSets[*].PermissionSetArn" --output text)

# Iterate over each permission set
for PERMISSION_SET_ARN in $PERMISSION_SETS; do
    # Extract permission set name from ARN
    PERMISSION_SET_NAME=$(echo $PERMISSION_SET_ARN | cut -d'/' -f2)

    # AWS CLI command to list accounts assigned to permission set
    ASSIGNED_ACCOUNTS=$(aws sso-admin list-account-assignments-for-permission-set --permission-set-arn $PERMISSION_SET_ARN --profile $SSO_PROFILE --query "AccountAssignments[*].[AccountId, PrincipalType, PrincipalName]" --output text)

    # Output to file in CSV format (AccountId, PermissionSetName, PrincipalType, PrincipalName)
    echo "$ASSIGNED_ACCOUNTS" | while read ACCOUNT_ID PRINCIPAL_TYPE PRINCIPAL_NAME; do
        echo "$ACCOUNT_ID, $PERMISSION_SET_NAME, $PRINCIPAL_TYPE, $PRINCIPAL_NAME" >> iam_relationship_backup.csv
    done
done

echo "IAM relationships backup completed."

