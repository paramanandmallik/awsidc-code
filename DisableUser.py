import boto3
import json

# Replace with your actual AWS credentials and Identity Store ID
IDENTITY_STORE_ID = 'd-sdg'
DRIDENTITY_STORE_ID = 'd-sgdgds'
userCheck = 'newtest01'

def disable_users(identity_store_id):
    try:
        session = boto3.Session()
        client = session.client('identitystore')
        
        # Method to fetch userId for a user
        get_user_id_response = client.get_user_id(
        IdentityStoreId=identity_store_id,
        AlternateIdentifier={
            'UniqueAttribute': {
                'AttributePath': 'userName',
                'AttributeValue': userCheck
            }
        },
        )
        print('UserID Response' ,get_user_id_response)
        
        # Method to iterate through all users in AWS Identity Center and filter one
    
        response = client.list_users(IdentityStoreId=identity_store_id)
        for users in response['Users']:
            if 'UserName' in users and users['UserId']:
                if users['UserName'] == userCheck:
                    print(users['UserName'], users['UserId'])
                    
                    # Method to Describe User
                    response = client.describe_user(IdentityStoreId=identity_store_id,UserId=users['UserId'])
                    print('Response',response)
                    
                    attrValue = {'Name': 'CostCenter', 'Value': 'Admin'}
                    
                    
                     # Method to Update User
                    # response = client.update_user(
                    #     IdentityStoreId=identity_store_id, 
                    #     UserId=users['UserId'],
                    #     Operations=[
                    #         {
                    #             'AttributePath': 'name.givenName',
                    #             'AttributeValue': 'newtest01'
                    #         }
                    #     ]
                    # )
                    attrValue = "userType"
                    attrValue = "locale"
                    attrValue = "phoneNumbers" 
                    # attrValue = "department" Not Supported
                    # attrValue = "emails.primary.value"
                    emailValue = [
                        {
                            "primary": True,
                            "value": "newmailaddress@xyz.com",
                            "type": "work"
                        }
                    ]


                    response = client.update_user(
                        IdentityStoreId=identity_store_id, 
                        UserId=users['UserId'],
                        Operations=[
                            {
                                'AttributePath': "emails",
                                'AttributeValue': emailValue
                            }
                        ]
                    )
                    
                    print('Response',response)

        
    except Exception as e:
        print(f"Error: {e}") 
        
def main():
    # Get AWS SSO credentials
    disable_users(DRIDENTITY_STORE_ID)
    

if __name__ == "__main__":
    main()
