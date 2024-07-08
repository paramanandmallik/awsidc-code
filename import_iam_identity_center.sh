#!/bin/bash

# Set the AWS profile to use
export AWS_PROFILE=param

read -p "Enter the AWS IAM Identity Center instance ARN: " INSTANCE_ARN

# Read from the backup YAML file
BACKUP_FILE="backup.yaml"

# Validate if the backup file exists and is not empty
if [ ! -s "$BACKUP_FILE" ]; then
    echo "Backup file $BACKUP_FILE is empty or does not exist."
    exit 1
fi

# Process each entry in the YAML file
while IFS= read -r line; do
    # Skip empty lines and comments
    if [[ -z "$line" || "$line" == "#"* ]]; then
        continue
    fi

    # Extract fields using direct parsing
    PERMISSION_SET_ARN=$(echo "$line" | awk '/PermissionSetArn/ {print $2}')
    ACCOUNT_ID=$(echo "$line" | awk '/AccountId/ {print $2}')
    ASSIGNMENTS=$(echo "$line" | awk '/Assignments/ {getline; print}')

    # Remove quotes if present
    PERMISSION_SET_ARN=$(echo "$PERMISSION_SET_ARN" | tr -d '"')
    ACCOUNT_ID=$(echo "$ACCOUNT_ID" | tr -d '"')

    # Check if all required fields are present
    if [ -z "$PERMISSION_SET_ARN" ] || [ -z "$ACCOUNT_ID" ] || [ -z "$ASSIGNMENTS" ]; then
        echo "Error: Invalid format in backup file at line:"
        echo "$line"
        continue
    fi

    echo "Processing Permission Set ARN: $PERMISSION_SET_ARN for Account ID: $ACCOUNT_ID"

    # Process each assignment
    while IFS= read -r assignment; do
        PRINCIPAL_ID=$(echo "$assignment" | awk '/PrincipalId/ {print $2}')
        PRINCIPAL_TYPE=$(echo "$assignment" | awk '/PrincipalType/ {print $2}')

        # Remove quotes if present
        PRINCIPAL_ID=$(echo "$PRINCIPAL_ID" | tr -d '"')
        PRINCIPAL_TYPE=$(echo "$PRINCIPAL_TYPE" | tr -d '"')

        # Check if assignment fields are present
        if [ -z "$PRINCIPAL_ID" ] || [ -z "$PRINCIPAL_TYPE" ]; then
            echo "Error: Invalid format in assignment data:"
            echo "$assignment"
            continue
        fi

        # Check if assignment already exists
        existing_assignment=$(aws sso-admin list-account-assignments-for-principal \
            --instance-arn $INSTANCE_ARN \
            --principal-type $PRINCIPAL_TYPE \
            --principal-id $PRINCIPAL_ID \
            --query "AccountAssignments[?PermissionSetArn=='$PERMISSION_SET_ARN' && AccountId=='$ACCOUNT_ID']" \
            --output json)

        if [[ ! -z $existing_assignment ]]; then
            echo "Assignment already exists for PrincipalId=$PRINCIPAL_ID, AccountId=$ACCOUNT_ID. Skipping."
        else
            echo "Creating assignment: PrincipalId=$PRINCIPAL_ID, PrincipalType=$PRINCIPAL_TYPE"

            aws sso-admin create-account-assignment \
                --instance-arn $INSTANCE_ARN \
                --permission-set-arn $PERMISSION_SET_ARN \
                --principal-type $PRINCIPAL_TYPE \
                --principal-id $PRINCIPAL_ID \
                --target-id $ACCOUNT_ID

            if [ $? -ne 0 ]; then
                echo "Failed to create assignment for PrincipalId=$PRINCIPAL_ID, AccountId=$ACCOUNT_ID"
            fi
        fi
    done <<< "$ASSIGNMENTS"

done < "$BACKUP_FILE"

echo "Import completed."

