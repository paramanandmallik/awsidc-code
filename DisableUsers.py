import boto3
import datetime

# Initialize the clients
identity_store_client = boto3.client('identitystore')
cloudtrail_client = boto3.client('cloudtrail')

# Define the identity store ID and the threshold for inactivity
identity_store_id = 'https://d-9sdfsd.awsapps.com/start'  # Replace with your Identity Store ID
inactivity_threshold = 90
cloudtrail_event_source = 'sso.amazonaws.com'

def lambda_handler(event, context):
    # Get the current date in UTC
    current_date = datetime.datetime.now(datetime.timezone.utc)
    
    # List users in the Identity Store
    users = list_users(identity_store_id)
    
    # Process each user
    for user in users:
        print('Inside for')
        user_id = user['UserId']
        user_name = user['UserName']
        print('username',user_name)
        # Check last login time
        last_login = get_last_login_time(user_name)
        
        if last_login:
            # Calculate the difference in days between the current date and the last login date
            days_inactive = (current_date - last_login).days
            
            # If the user has been inactive for more than the threshold, disable the user
            if days_inactive >= inactivity_threshold:
                set_user_status(user_id, 'Inactive')
                print(f"Set user {user_name} (ID: {user_id}) to 'Inactive' due to inactivity of {days_inactive} days.")
        else:
            print(f"User {user_name} (ID: {user_id}) has never logged in.")
    
def list_users(identity_store_id):
    # List all users in the identity store
    response = identity_store_client.list_users(IdentityStoreId=identity_store_id)
    return response['Users']

def get_last_login_time(user_name):
    # Query CloudTrail logs for the last login time of the user
    response = cloudtrail_client.lookup_events(
        LookupAttributes=[
            {
                'AttributeKey': 'EventName',
                'AttributeValue': 'ConsoleLogin'
            },
            {
                'AttributeKey': 'Username',
                'AttributeValue': user_name
            }
        ],
        StartTime=datetime.datetime.now(datetime.timezone.utc) - datetime.timedelta(days=365),
        EndTime=datetime.datetime.now(datetime.timezone.utc),
        MaxResults=1
    )
    
    events = response.get('Events', [])
    
    if events:
        # Return the latest login time
        return max(event['EventTime'] for event in events)
    
    return None

def set_user_status(user_id, status):
    # Set the custom attribute 'UserStatus' to 'Inactive'
    response = identity_store_client.update_user(
        IdentityStoreId=identity_store_id,
        UserId=user_id,
        Operations=[
            {
                'AttributePath': 'UserStatus',
                'Value': status
            }
        ]
    )
    return response