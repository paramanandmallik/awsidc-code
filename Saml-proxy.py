import json
import base64
import boto3
import xml.etree.ElementTree as ET

# Initialize the boto3 clients
identity_center_client = boto3.client('identitystore')

def lambda_handler(event, context):
    try:
        # Get SAML response from the event
        saml_response = event['saml_response']
        
        # Decode and parse the SAML response
        decoded_saml_response = base64.b64decode(saml_response)
        root = ET.fromstring(decoded_saml_response)
        
        # Extract user parameters from the SAML response
        user_attributes = extract_user_attributes(root)
        
        # Check if the user exists in IAM Identity Center
        user_exists = check_user_exists(user_attributes['Username'])
        
        if not user_exists:
            # Create the user if they do not exist
            create_user(user_attributes)
        
        return {
            'statusCode': 200,
            'body': json.dumps('User processed successfully.')
        }
        
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error processing user: {str(e)}")
        }

def extract_user_attributes(root):
    # Extract user attributes from the SAML response XML
    namespace = {'saml': 'urn:oasis:names:tc:SAML:2.0:assertion'}
    attributes = {}
    
    for attr in root.findall('.//saml:Attribute', namespace):
        attr_name = attr.get('Name')
        attr_value = attr.find('.//saml:AttributeValue', namespace).text
        
        if attr_name == 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress':
            attributes['Email'] = attr_value
        elif attr_name == 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name':
            attributes['Username'] = attr_value
        elif attr_name == 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname':
            attributes['GivenName'] = attr_value
        elif attr_name == 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname':
            attributes['FamilyName'] = attr_value
    
    return attributes

def check_user_exists(username):
    try:
        response = identity_center_client.list_users(
            Filters=[
                {
                    'AttributePath': 'userName',
                    'AttributeValue': username
                }
            ]
        )
        return len(response['Users']) > 0
    except identity_center_client.exceptions.ResourceNotFoundException:
        return False

def create_user(user_attributes):
    try:
        response = identity_center_client.create_user(
            UserName=user_attributes['Username'],
            Name={
                'GivenName': user_attributes['GivenName'],
                'FamilyName': user_attributes['FamilyName']
            },
            EmailAddress=user_attributes['Email']
        )
        return response
    except Exception as e:
        raise Exception(f"Error creating user: {str(e)}")

