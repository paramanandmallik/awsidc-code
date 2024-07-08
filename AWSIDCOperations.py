import boto3

# Replace with your actual AWS credentials and Identity Store IDs
IDENTITY_STORE_ID = 'd-sfd'
DRIDENTITY_STORE_ID = 'd-sdff'
userCheck = 'newtest01'

def get_session():
    try:
       session = boto3.Session()
       client = session.client('identitystore')
       return client
    
    except Exception as e:
        print(f"Error getting connection: {e}")
        return None
    
def get_user_id(identity_store_id, user_check):
    try:
      
        client = get_session()
        
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
        print('UserID Response:', response)
        return response['UserId']
    
    except Exception as e:
        print(f"Error fetching user ID: {e}")
        return None

def describe_user(identity_store_id, user_name):
    try:
        client = get_session()
        user_id = get_user_id(DRIDENTITY_STORE_ID,user_name)
        # Method to describe a user
        response = client.describe_user(
            IdentityStoreId=identity_store_id,
            UserId=user_id
        )
        print('Describe User Response:', response)
        return response
    
    except Exception as e:
        print(f"Error describing user: {e}")
        return None

def update_user_email(identity_store_id,user_name, email_value):
    try:
        client = get_session()
        user_id = get_user_id(DRIDENTITY_STORE_ID,user_name)
        emailValue = [
                {
                    "primary": True,
                    "value": email_value,
                    "type": "work"
                    }
                ]
        # Method to update user email
        response = client.update_user(
            IdentityStoreId=identity_store_id,
            UserId=user_id,
            Operations=[
                {
                    'AttributePath': 'emails',
                    'AttributeValue': emailValue
                }
            ]
        )
        print('Update User Response:', response)
        return response
    
    except Exception as e:
        print(f"Error updating user email: {e}")
        return None

def change_user_status(identity_store_id,user_name,status):
    try:
        client = get_session()
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

def main():
      
    # userId = get_user_id(DRIDENTITY_STORE_ID,userCheck)
    # update_user_email(DRIDENTITY_STORE_ID,userCheck, "NewMail@newdomain.com")
    # change_user_status(DRIDENTITY_STORE_ID,userCheck,'Active')
    describe_user(DRIDENTITY_STORE_ID,userCheck)

if __name__ == "__main__":
    main()
