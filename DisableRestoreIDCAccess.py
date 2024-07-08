import boto3
from datetime import datetime, timedelta

# Replace with your actual AWS credentials and Identity Store IDs
IDENTITY_STORE_ID = 'd-df'
# Secondary Identity Center
DRIDENTITY_STORE_ID = 'd-fdsf'
# UserName for per-user testing
userCheck = 'newtest01'

def get_session():
    try:
       session = boto3.Session()
       client = session.client('identitystore')
       return session
    
    except Exception as e:
        print(f"Error getting connection: {e}")
        return None
    
def get_user_id(identity_store_id, user_check):
    try:
      
        session = get_session()
        client = session.client('identitystore')
        
        # Method to fetch userId for a user
        response = client.get_user_id(
            IdentityStoreId=identity_store_id,
            AlternateIdentifier={
                'UniqueAttribute': {
                    'AttributePath': 'userName',
                    'AttributeValue': user_check
                }
            },
        )
        return response['UserId']
    
    except Exception as e:
        print(f"Error fetching user ID: {e}")
        return None

def change_user_status(identity_store_id,user_name,status):
    try:
        session = get_session()
        client = session.client('identitystore')
        
        user_id = get_user_id(DRIDENTITY_STORE_ID,user_name)
        # Method to list users and perform operations
        response = client.update_user(
            IdentityStoreId=identity_store_id,
            UserId=user_id,
            Operations=[
                {
                    'AttributePath': "userType",
                    'AttributeValue': status
                    }
                ]
            )
    except Exception as e:
        print(f"Error: {e}")

def listInactiveUsers(identity_store_id):
    try:
        session = get_session()
        client = session.client('identitystore')
        
        response = client.list_users(IdentityStoreId=identity_store_id)
        for user in response['Users']:
            userStatus = get_last_login_from_cloudtrail(user['UserName'])
            userName = user['UserName']
            print('User Status:', userStatus, 'for user', userName)
            if userStatus=='Active':
                change_user_status(DRIDENTITY_STORE_ID, userName, 'Active')
                print('Status updated to Active for User')
                
            else:
                change_user_status(DRIDENTITY_STORE_ID, userName, 'Inactive')
                print('Status updated to Inactive for User')
    
    except Exception as e:
        print(f"Error: {e}")
    
def get_last_login_from_cloudtrail(userName):
    try:
        
        session = get_session()
        client = session.client('cloudtrail')
        user_id = get_user_id(DRIDENTITY_STORE_ID, userName)
        
        # Search CloudTrail logs for ConsoleLogin events for the specific user
        end_time = datetime.now()
        start_time = end_time - timedelta(days=30)  # Search for events within the last 30 days (adjust as needed)

        response = client.lookup_events(
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
            print('Event Time', event_time)
            diff = datetime.now() - event_time.replace(tzinfo=None)
            inactiveHours = diff.total_seconds()/3600
            if inactiveHours>=2:
                return 'Inactive'
            else:
                return 'Active'

        return None

    except Exception as e:
        print(f"Error retrieving last login from CloudTrail for user {user_id}: {e}")
        return None

def main():
    listInactiveUsers(DRIDENTITY_STORE_ID)  
    # userActivity = get_last_login_from_cloudtrail(userCheck)
    
    # change_user_status(DRIDENTITY_STORE_ID,userCheck,'Active')

if __name__ == "__main__":
    main()
