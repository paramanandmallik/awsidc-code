import json
import base64
import boto3
import xml.etree.ElementTree as ET

identity_store_id = 'd-dfsds'

def getConnection():
    try:
        session = boto3.Session()
        identity_center_client = session.client('identitystore')
        return identity_center_client
    except Exception as e:
        print(f"Error processing user: {str(e)}")

def main(saml_response):
    try:
        # Decode and parse the SAML response
        decoded_saml_response = base64.b64decode(saml_response)
        root = ET.fromstring(decoded_saml_response)
        print(f"saml {root}")
        
        # Extract user parameters from the SAML response
        user_attributes = extract_user_attributes(root)
        
        # Check if the user exists in IAM Identity Center
        user_exists = check_user_exists(user_attributes['Email'])
        
        if not user_exists:
            # Create the user if they do not exist
            create_user(user_attributes)
        
        print('User processed successfully.')
        
    except Exception as e:
        print(f"Error processing user: {str(e)}")

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
    print(f"userName: {username}")
    try:
        identity_center_client = getConnection()
        response = identity_center_client.get_user_id(
            IdentityStoreId=identity_store_id,
            AlternateIdentifier={
                'UniqueAttribute': {
                    'AttributePath': 'userName',
                    'AttributeValue': username
                }
            },
        )
        return len(response['Users']) > 0
    except identity_center_client.exceptions.ResourceNotFoundException:
        return False

def create_user(user_attributes):
    try:
        identity_center_client = getConnection()
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

if __name__ == "__main__":
    # Example SAML response (Base64 encoded)
    saml_response = "PHNhbWwycDpSZXNwb25zZSB4bWxuczpzYW1sMnA9InVybjpvYXNpczpuYW1lczp0YzpTQU1MOjIuMDpwcm90b2NvbCINCiAgICAgICAgICAgICAgICAgRGVzdGluYXRpb249Imh0dHBzOi8vdXMtZWFzdC0xLnNpZ25pbi5hd3MuYW1hem9uLmNvbS9wbGF0Zm9ybS9zYW1sL2Fjcy8wZjlkNjM0My1mNmJkLTRhMTMtODJiMy0wMTdkZTFhNDhjMjQiDQogICAgICAgICAgICAgICAgIElEPSJfODNkMDQyYTktYTc2YS00MWQ1LTkxZDgtZmIxYTVlOTJmYjk1Ig0KICAgICAgICAgICAgICAgICBJblJlc3BvbnNlVG89ImF3c19qS1JRWm5vT1oyODBGVlFCVktRaTI4b1JYZnVZMk5FaCINCiAgICAgICAgICAgICAgICAgSXNzdWVJbnN0YW50PSIyMDI0LTA3LTA0VDA2OjU3OjIyLjEwNloiDQogICAgICAgICAgICAgICAgIFZlcnNpb249IjIuMCINCiAgICAgICAgICAgICAgICAgPg0KICAgIDxzYW1sMjpJc3N1ZXIgeG1sbnM6c2FtbDI9InVybjpvYXNpczpuYW1lczp0YzpTQU1MOjIuMDphc3NlcnRpb24iPmh0dHBzOi8vaWRwLWludGVnLmZlZGVyYXRlLmFtYXpvbi5jb208L3NhbWwyOklzc3Vlcj4NCiAgICA8c2FtbDJwOlN0YXR1cz4NCiAgICAgICAgPHNhbWwycDpTdGF0dXNDb2RlIFZhbHVlPSJ1cm46b2FzaXM6bmFtZXM6dGM6U0FNTDoyLjA6c3RhdHVzOlN1Y2Nlc3MiIC8+DQogICAgPC9zYW1sMnA6U3RhdHVzPg0KICAgIDxzYW1sMjpBc3NlcnRpb24geG1sbnM6c2FtbDI9InVybjpvYXNpczpuYW1lczp0YzpTQU1MOjIuMDphc3NlcnRpb24iDQogICAgICAgICAgICAgICAgICAgICBJRD0iX0kyNDA3MDQwNjU3MjExODBQRFhaTEVZNEtTV1BXUlgiDQogICAgICAgICAgICAgICAgICAgICBJc3N1ZUluc3RhbnQ9IjIwMjQtMDctMDRUMDY6NTc6MjIuMTA2WiINCiAgICAgICAgICAgICAgICAgICAgIFZlcnNpb249IjIuMCINCiAgICAgICAgICAgICAgICAgICAgID4NCiAgICAgICAgPHNhbWwyOklzc3Vlcj5odHRwczovL2lkcC1pbnRlZy5mZWRlcmF0ZS5hbWF6b24uY29tPC9zYW1sMjpJc3N1ZXI+DQogICAgICAgIDxkczpTaWduYXR1cmUgeG1sbnM6ZHM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyMiPg0KICAgICAgICAgICAgPGRzOlNpZ25lZEluZm8+DQogICAgICAgICAgICAgICAgPGRzOkNhbm9uaWNhbGl6YXRpb25NZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzEwL3htbC1leGMtYzE0biNXaXRoQ29tbWVudHMiIC8+DQogICAgICAgICAgICAgICAgPGRzOlNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGEyNTYiIC8+DQogICAgICAgICAgICAgICAgPGRzOlJlZmVyZW5jZSBVUkk9IiNfSTI0MDcwNDA2NTcyMTE4MFBEWFpMRVk0S1NXUFdSWCI+DQogICAgICAgICAgICAgICAgICAgIDxkczpUcmFuc2Zvcm1zPg0KICAgICAgICAgICAgICAgICAgICAgICAgPGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNlbnZlbG9wZWQtc2lnbmF0dXJlIiAvPg0KICAgICAgICAgICAgICAgICAgICAgICAgPGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMTAveG1sLWV4Yy1jMTRuI1dpdGhDb21tZW50cyIgLz4NCiAgICAgICAgICAgICAgICAgICAgPC9kczpUcmFuc2Zvcm1zPg0KICAgICAgICAgICAgICAgICAgICA8ZHM6RGlnZXN0TWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS8wNC94bWxlbmMjc2hhMjU2IiAvPg0KICAgICAgICAgICAgICAgICAgICA8ZHM6RGlnZXN0VmFsdWU+cklZYlFOWVk3V3lCMEJES3kySDh2YmJ0c0tQNldCRFJ3N00vRld0ZHprMD08L2RzOkRpZ2VzdFZhbHVlPg0KICAgICAgICAgICAgICAgIDwvZHM6UmVmZXJlbmNlPg0KICAgICAgICAgICAgPC9kczpTaWduZWRJbmZvPg0KICAgICAgICAgICAgPGRzOlNpZ25hdHVyZVZhbHVlPlZJdTQzdTJJNGQyalRFdng3eEtRbXl3bjlNTU5tOEsxNVh5QS9UblNJaUhxZmp3RGp6SlI3SERVaW9lL3B4a2JWL21HYk5iSkJyVytudzJSaG5zQXEwL0MzcmFha3lQM3BHTWZzNlR4bGljTmlOcWduUWpxb00ybExHOE9NOHFNMmdHcW9DaFMvcjdGc2V0ajgzMzRBS1BvcVdXODE1YVFyTi9VdWc4dTJ5dXhNSTlLTnFZZnBpLzVDTndnUTBhMGhQaTVUaStXK1krclVmUGNyYXdUbEw5WDN3Z0tlWjJERHg2bFVRbXpoSnVRbGFRYm1qdGhZVW94eXUzSkQvOXp3V3hqdDVwUFpzNXpTd3lLcThJZmMzbXhaQkhTMThCaU1NNHRiUzFoZEhYVFYzZndKOTFpd1pSQ2pCY3ZTR2huUkpKYVVqSUhyNEhlbUtYTUN6MCt5dz09PC9kczpTaWduYXR1cmVWYWx1ZT4NCiAgICAgICAgICAgIDxkczpLZXlJbmZvPg0KICAgICAgICAgICAgICAgIDxkczpYNTA5RGF0YT4NCiAgICAgICAgICAgICAgICAgICAgPGRzOlg1MDlDZXJ0aWZpY2F0ZT5NSUlGOFRDQ0JObWdBd0lCQWdJUUJsUFpQZG9vTFNENzgzck5yTzBsT3pBTkJna3Foa2lHOXcwQkFRc0ZBREE4TVFzd0NRWURWUVFHRXdKVlV6RVBNQTBHQTFVRUNoTUdRVzFoZW05dU1Sd3dHZ1lEVlFRREV4TkJiV0Y2YjI0Z1VsTkJJREl3TkRnZ1RUQXhNQjRYRFRJME1EWXdOREF3TURBd01Gb1hEVEkxTURVeU5qSXpOVGsxT1Zvd0xURXJNQ2tHQTFVRUF4TWljMkZ0YkM1cFpIQXRhVzUwWldjdVptVmtaWEpoZEdVdVlXMWhlbTl1TG1OdmJUQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQUsyNzJYcGVldFd4Z0Jma3Jyb1RvOTlOcU9uaGp0RGVzaXRSVS9EOTdiKzNlUW9ZTSs0MHpLWk91ekVXSUdpbllqVEpjVS9uZXk2OXBNaksxL3NxQmw3dGhidmEra2Ird29qTmpORHBHbzBDait0VlV4QW9wcG1GMEYwdmthTkRiS1Fya3dhWVd2OS9KQ0w5eUpReFZEY25hYlZBSldVbXh2b2E4dnRNM0NJdjVIcVhocjMrZ0g4QjQ2QmFpVSttdENPa1djRkRiK3dpYzlIMUM3YnovZ2dNZllBYzdjNzVOWVlvMVhYWDZEVnRoVU8zNGhQU3llQkNvaGU5WFhqVnlycndwOXJlZ2orN0VLMytjRStyZWVvYlJISXlyMGs2aFpYRmlsM1dhUklERFJrVFA4MGpIMkE2b0dNcVlwRmNwZDJxL0w3ZHZqd1pGNTc4VXJFcEJua0NBd0VBQWFPQ0F2d3dnZ0w0TUI4R0ExVWRJd1FZTUJhQUZJRzREbU9LaVJJWTVmbzdPMUNWbitibGtCT0ZNQjBHQTFVZERnUVdCQlMwN1FTZlRDTVl6My9IcS9mRmJ6ZGptTnRsZ1RBdEJnTlZIUkVFSmpBa2dpSnpZVzFzTG1sa2NDMXBiblJsWnk1bVpXUmxjbUYwWlM1aGJXRjZiMjR1WTI5dE1CTUdBMVVkSUFRTU1Bb3dDQVlHWjRFTUFRSUJNQTRHQTFVZER3RUIvd1FFQXdJRm9EQWRCZ05WSFNVRUZqQVVCZ2dyQmdFRkJRY0RBUVlJS3dZQkJRVUhBd0l3T3dZRFZSMGZCRFF3TWpBd29DNmdMSVlxYUhSMGNEb3ZMMk55YkM1eU1tMHdNUzVoYldGNmIyNTBjblZ6ZEM1amIyMHZjakp0TURFdVkzSnNNSFVHQ0NzR0FRVUZCd0VCQkdrd1p6QXRCZ2dyQmdFRkJRY3dBWVloYUhSMGNEb3ZMMjlqYzNBdWNqSnRNREV1WVcxaGVtOXVkSEoxYzNRdVkyOXRNRFlHQ0NzR0FRVUZCekFDaGlwb2RIUndPaTh2WTNKMExuSXliVEF4TG1GdFlYcHZiblJ5ZFhOMExtTnZiUzl5TW0wd01TNWpaWEl3REFZRFZSMFRBUUgvQkFJd0FEQ0NBWDhHQ2lzR0FRUUIxbmtDQkFJRWdnRnZCSUlCYXdGcEFIY0FUbldqSjF5YUVNTTRXMnpVM3o5UzZ4M3c0STRialduQXNmcGtzV0thT2Q4QUFBR1A0dGdHY0FBQUJBTUFTREJHQWlFQTZkUUd3Zng5WktNVFc5MWd2bW1vWWpHRjYzYTBaYloxdi85MlJFWGY2WHdDSVFEQ2EvUmhVdVZCaFZHWk1GWWVrVTNXRitVczJ3SStvRUtxRXhhM3pkYWQrd0IxQUgxWkhoTGhlQ3A3SEdGbmZGNzkrTkNIWEJTZ1RwV2V1UU12MlE2TUxubTRBQUFCaitMWUJxNEFBQVFEQUVZd1JBSWdORVdYSmNPMVZ6MXdHc3ZxUDRZcjFmbCt4c1FHYnExcWtZMUhWaysrNFFvQ0lIY1lOMGdYQ2RDSk1vdDRHZW5Bc3F2MVJYdmJnd1dnMFN5N1VreW5DQUdKQUhjQXp4Rlc3dFV1ZksvemgxdlphUzZiNlJweFowcXdGK3lzQWRKYmQ4N01Pd2dBQUFHUDR0Z0dxQUFBQkFNQVNEQkdBaUVBeVl5Y2hBOFkrbjlTckwxTER0bEZsdjFNVUhpSDNXcFpEcmtJV3MrQXVZb0NJUUM1WlYzajZwM2lrazYweTRMOXY0SWg3VHY2TnI5NE9ZS3g5NnRwcG5HNEFEQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFQdWZEaFN5UUVhdW91ZEpkNmFyS3J6M00xKzFJbmFyS3dRcDkvcFI0R1M5SkNjL3YvN2xKMUZ0OFd1UmpCbDFZd1NFQXlxbVN5ZkdZZ2FXYk1RNUd2SWZxM2VoYUlJUHI3M25yeTlPbWkycE5ndXVCZVM1Mmx0N0FpRWkybFNLeldxUGErSmtrcG1OTW5tRnFZV3NSTFVNOUJaVXNTODNkN0FKeXdER2lpWWpnMFQzbkhTSkZTV216am9sVkVrS1lVL25wTS9UbEtFZmVEdUpRQTg0MzRTSllVN1pBcDFqT21Sa3VoN2M4WlFoVk81WXEzeFJZTUJtTHNxZ3F5SDFXdm1HeTgyRm5PcHlkdXJsRTg2RFpXbDMzL0VBbllIaVhoTU1NTm1YL0NrVmVwVGpHbDVkODNiYm9hUHdwRDhEU1RZQnB6UXdlY3lhN1AvbEtBNWlPL3c9PTwvZHM6WDUwOUNlcnRpZmljYXRlPg0KICAgICAgICAgICAgICAgIDwvZHM6WDUwOURhdGE+DQogICAgICAgICAgICA8L2RzOktleUluZm8+DQogICAgICAgIDwvZHM6U2lnbmF0dXJlPg0KICAgICAgICA8c2FtbDI6U3ViamVjdD4NCiAgICAgICAgICAgIDxzYW1sMjpOYW1lSUQgRm9ybWF0PSJ1cm46b2FzaXM6bmFtZXM6dGM6U0FNTDoxLjE6bmFtZWlkLWZvcm1hdDplbWFpbEFkZHJlc3MiPnBhcmFtZG10ZXN0QGFtYXpvbi5jb208L3NhbWwyOk5hbWVJRD4NCiAgICAgICAgICAgIDxzYW1sMjpTdWJqZWN0Q29uZmlybWF0aW9uIE1ldGhvZD0idXJuOm9hc2lzOm5hbWVzOnRjOlNBTUw6Mi4wOmNtOmJlYXJlciI+DQogICAgICAgICAgICAgICAgPHNhbWwyOlN1YmplY3RDb25maXJtYXRpb25EYXRhIEluUmVzcG9uc2VUbz0iYXdzX2pLUlFabm9PWjI4MEZWUUJWS1FpMjhvUlhmdVkyTkVoIg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOb3RPbk9yQWZ0ZXI9IjIwMjQtMDctMDRUMDc6MDA6MjIuMTA2WiINCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmVjaXBpZW50PSJodHRwczovL3VzLWVhc3QtMS5zaWduaW4uYXdzLmFtYXpvbi5jb20vcGxhdGZvcm0vc2FtbC9hY3MvMGY5ZDYzNDMtZjZiZC00YTEzLTgyYjMtMDE3ZGUxYTQ4YzI0Ig0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvPg0KICAgICAgICAgICAgPC9zYW1sMjpTdWJqZWN0Q29uZmlybWF0aW9uPg0KICAgICAgICA8L3NhbWwyOlN1YmplY3Q+DQogICAgICAgIDxzYW1sMjpDb25kaXRpb25zIE5vdEJlZm9yZT0iMjAyNC0wNy0wNFQwNjo1NDoyMi4xMDZaIg0KICAgICAgICAgICAgICAgICAgICAgICAgICBOb3RPbk9yQWZ0ZXI9IjIwMjQtMDctMDRUMDc6MDA6MjIuMTA2WiINCiAgICAgICAgICAgICAgICAgICAgICAgICAgPg0KICAgICAgICAgICAgPHNhbWwyOkF1ZGllbmNlUmVzdHJpY3Rpb24+DQogICAgICAgICAgICAgICAgPHNhbWwyOkF1ZGllbmNlPmh0dHBzOi8vdXMtZWFzdC0xLnNpZ25pbi5hd3MuYW1hem9uLmNvbS9wbGF0Zm9ybS9zYW1sL2QtOTA2N2ViZDQyZjwvc2FtbDI6QXVkaWVuY2U+DQogICAgICAgICAgICA8L3NhbWwyOkF1ZGllbmNlUmVzdHJpY3Rpb24+DQogICAgICAgIDwvc2FtbDI6Q29uZGl0aW9ucz4NCiAgICAgICAgPHNhbWwyOkF1dGhuU3RhdGVtZW50IEF1dGhuSW5zdGFudD0iMjAyNC0wNy0wNFQwNjo1NzoyMi4xMDZaIg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU2Vzc2lvbkluZGV4PSJfSTI0MDcwNDA2NTcyMTE4MFBEWFpMRVk0S1NXUFdSWCINCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNlc3Npb25Ob3RPbk9yQWZ0ZXI9IjIwMjQtMDctMDRUMTY6NTc6MjIuMTA2WiINCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID4NCiAgICAgICAgICAgIDxzYW1sMjpBdXRobkNvbnRleHQ+DQogICAgICAgICAgICAgICAgPHNhbWwyOkF1dGhuQ29udGV4dENsYXNzUmVmPnVybjpvYXNpczpuYW1lczp0YzpTQU1MOjIuMDphYzpjbGFzc2VzOlBhc3N3b3JkUHJvdGVjdGVkVHJhbnNwb3J0PC9zYW1sMjpBdXRobkNvbnRleHRDbGFzc1JlZj4NCiAgICAgICAgICAgIDwvc2FtbDI6QXV0aG5Db250ZXh0Pg0KICAgICAgICA8L3NhbWwyOkF1dGhuU3RhdGVtZW50Pg0KICAgIDwvc2FtbDI6QXNzZXJ0aW9uPg0KPC9zYW1sMnA6UmVzcG9uc2U+"
    
    main(saml_response)
