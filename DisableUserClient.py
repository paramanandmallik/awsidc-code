import boto3
from datetime import datetime, timedelta

# Hardcoded AWS SSO credentials (example, replace with your actual credentials)

# Initialize the clients
identity_store_client = boto3.client('identitystore')
cloudtrail_client = boto3.client('cloudtrail') 


def disable_active_users():
    try:

        # Create a session using hardcoded AWS SSO credentials
        session = boto3.Session()

        # Initialize clients with the session
        identity_store_client = session.client('identitystore')
        cloudtrail_client = session.client('cloudtrail')

        # Example: List users and disable inactive ones
        identity_store_id = 'd-9067a2d51d'  # Replace with your Identity Store ID
        response = identity_store_client.list_users(IdentityStoreId=identity_store_id)

    
        for user in response['Users']:
            # Check if 'Username' attribute is present in the user object
            if 'UserName' in user and user['UserName']:
                user_name = user['UserName']
                print(f"Processing user: {user}")

                # Assuming 'UserType' is a custom attribute in user profile indicating 'Active' or 'Inactive'
                UserType = user['DisplayName']
                print('MiddleName', UserType)
                if UserType != 'Active':
                    user_id = user['UserId']
                    print('user Id',user_id)
                    
                    attributePath = 'CostCenter';
                    attributeValue={
                        'DisplayName': 'Inactive'
                    } 

                    # Example: Disable user (update user attributes to set UserType to 'Inactive')
                    response = identity_store_client.update_user(
                        IdentityStoreId=identity_store_id,  # Replace with your Identity Store ID
                        UserId=user_id,
                        Operations=[
                            {
                                'AttributePath': attributePath,
                                'AttributeValue': attributeValue
                            }
                        ]
                    )
  
                    print(f"User ID: {user_id} disabled.")

                    # Track last login time using CloudTrail
                    last_login_time = get_last_login_from_cloudtrail(user_id)
                    if last_login_time:
                        print(f"Last login time for User ID {user_id}: {last_login_time}")
            else:
                print(f"UserType not found for user: {user}")
    
    except Exception as e:
        print(f"Error: {e}")

def get_last_login_from_cloudtrail(user_id):
    try:
        # Search CloudTrail logs for ConsoleLogin events for the specific user
        end_time = datetime.now()
        start_time = end_time - timedelta(days=30)  # Search for events within the last 30 days (adjust as needed)

        response = cloudtrail_client.lookup_events(
            LookupAttributes=[
                {'AttributeKey': 'EventName', 'AttributeValue': 'ConsoleLogin'},
                {'AttributeKey': 'Username', 'AttributeValue': user_id}
            ],
            StartTime=start_time,
            EndTime=end_time,
            MaxResults=1,
            )
        
        # Check if ConsoleLogin event found
        print('StartTime', start_time)
        if 'Events' in response and len(response['Events']) > 0:
            event = response['Events'][0]
            event_time = event['EventTime']
            return event_time

        return None

    except Exception as e:
        print(f"Error retrieving last login from CloudTrail for user {user_id}: {e}")
        return None

def main():
    disable_active_users()

if __name__ == "__main__":
    main()