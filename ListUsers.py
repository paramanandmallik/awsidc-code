import boto3
from botocore.exceptions import NoCredentialsError

# Initialize the clients
sso_client = boto3.client('sso')
identity_store_client = None
cloudtrail_client = None

def list_users(identity_store_id):
    try:
        global identity_store_client
        if identity_store_client is None:
            identity_store_client = boto3.client('identitystore')
        # List all users in the identity store
        response = identity_store_client.list_users(IdentityStoreId=identity_store_id)
        return response['Users']
    except Exception as e:
        print(f"Error listing users: {e}")
        return []

def main():

    # Create a session using AWS SSO credentials
    session = boto3.Session()

    # Initialize clients with the session
    global identity_store_client
    if identity_store_client is None:
        identity_store_client = session.client('identitystore')
    global cloudtrail_client
    if cloudtrail_client is None:
        cloudtrail_client = session.client('cloudtrail')

    # Example: List users in Identity Store
    try:
        identity_store_id = 'd-9067e92039'  # Replace with your Identity Store ID
        users = list_users(identity_store_id)
        if users:
            print("List of users:")
            for user in users:
                print(f"User ID: {user['UserId']}, Username: {user['UserName']}")
        else:
            print("No users found in Identity Store.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
