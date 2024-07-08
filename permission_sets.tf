
resource "aws_ssoadmin_permission_set" "OrganizationsAdmin" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "OrganizationsAdmin"
  description         = "OrganizationsAdmin"
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_account_assignment" "OrganizationsAdmin_267762668325_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-dd1e649efbfa9f48"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "267762668325"
}

resource "aws_ssoadmin_account_assignment" "OrganizationsAdmin_364170696417_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-dd1e649efbfa9f48"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "OrganizationsAdmin_364170696417_74c864e8-60c1-702d-fd70-9dab53377ac9" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-dd1e649efbfa9f48"
  principal_id        = "74c864e8-60c1-702d-fd70-9dab53377ac9"
  principal_type      = "USER"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_permission_set" "AdministratorAccess" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "AdministratorAccess"
  description         = ""
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_account_assignment" "AdministratorAccess_364170696417_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-ebc64c80ed3ec37e"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "AdministratorAccess_364170696417_f4e84498-c0f1-706a-b0f3-20c98d405005" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-ebc64c80ed3ec37e"
  principal_id        = "f4e84498-c0f1-706a-b0f3-20c98d405005"
  principal_type      = "USER"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "AdministratorAccess_693088575159_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-ebc64c80ed3ec37e"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "693088575159"
}

resource "aws_ssoadmin_account_assignment" "AdministratorAccess_962265335633_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-ebc64c80ed3ec37e"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "962265335633"
}

resource "aws_ssoadmin_permission_set" "AWSServiceCatalogAdminFullAccess" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "AWSServiceCatalogAdminFullAccess"
  description         = "Provides full access to AWS Service Catalog admin capabilities"
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_account_assignment" "AWSServiceCatalogAdminFullAccess_364170696417_2428f4b8-6001-7011-73fb-99f40542134a" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-88e54505f0768454"
  principal_id        = "2428f4b8-6001-7011-73fb-99f40542134a"
  principal_type      = "GROUP"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_permission_set" "AWSServiceCatalogEndUserAccess" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "AWSServiceCatalogEndUserAccess"
  description         = "Provides access to the AWS Service Catalog end user console"
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_account_assignment" "AWSServiceCatalogEndUserAccess_364170696417_94b8f4d8-b0b1-70d5-a87d-60d496f07188" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-0df73a7c1aa97db2"
  principal_id        = "94b8f4d8-b0b1-70d5-a87d-60d496f07188"
  principal_type      = "GROUP"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_permission_set" "ViewOnlyAccessOnelogin" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "ViewOnlyAccessOnelogin"
  description         = "ViewOnlyAccessOnelogin"
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_permission_set" "AWSPowerUserAccess" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "AWSPowerUserAccess"
  description         = "Provides full access to AWS services and resources, but does not allow management of Users and groups"
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_025651520535_f4a894e8-d021-705b-ddcf-02c37374bc5c" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "f4a894e8-d021-705b-ddcf-02c37374bc5c"
  principal_type      = "GROUP"
  target_id           = "025651520535"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_025651520535_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "025651520535"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_109576666270_f4a894e8-d021-705b-ddcf-02c37374bc5c" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "f4a894e8-d021-705b-ddcf-02c37374bc5c"
  principal_type      = "GROUP"
  target_id           = "109576666270"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_109576666270_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "109576666270"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_140184854818_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "140184854818"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_140184854818_f4a894e8-d021-705b-ddcf-02c37374bc5c" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "f4a894e8-d021-705b-ddcf-02c37374bc5c"
  principal_type      = "GROUP"
  target_id           = "140184854818"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_211125763900_f4a894e8-d021-705b-ddcf-02c37374bc5c" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "f4a894e8-d021-705b-ddcf-02c37374bc5c"
  principal_type      = "GROUP"
  target_id           = "211125763900"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_267762668325_f4a894e8-d021-705b-ddcf-02c37374bc5c" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "f4a894e8-d021-705b-ddcf-02c37374bc5c"
  principal_type      = "GROUP"
  target_id           = "267762668325"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_339712898296_f4a894e8-d021-705b-ddcf-02c37374bc5c" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "f4a894e8-d021-705b-ddcf-02c37374bc5c"
  principal_type      = "GROUP"
  target_id           = "339712898296"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_364170696417_f4a894e8-d021-705b-ddcf-02c37374bc5c" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "f4a894e8-d021-705b-ddcf-02c37374bc5c"
  principal_type      = "GROUP"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_433803933728_f4a894e8-d021-705b-ddcf-02c37374bc5c" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "f4a894e8-d021-705b-ddcf-02c37374bc5c"
  principal_type      = "GROUP"
  target_id           = "433803933728"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_546106908048_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "546106908048"
}

resource "aws_ssoadmin_account_assignment" "AWSPowerUserAccess_546106908048_f4a894e8-d021-705b-ddcf-02c37374bc5c" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-1de9d74187089052"
  principal_id        = "f4a894e8-d021-705b-ddcf-02c37374bc5c"
  principal_type      = "GROUP"
  target_id           = "546106908048"
}

resource "aws_ssoadmin_permission_set" "AWSOrganizationsFullAccess" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "AWSOrganizationsFullAccess"
  description         = "Provides full access to AWS Organizations"
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_025651520535_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "025651520535"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_025651520535_9458e448-b001-7092-b57c-869b29ecbc05" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "9458e448-b001-7092-b57c-869b29ecbc05"
  principal_type      = "GROUP"
  target_id           = "025651520535"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_109576666270_9458e448-b001-7092-b57c-869b29ecbc05" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "9458e448-b001-7092-b57c-869b29ecbc05"
  principal_type      = "GROUP"
  target_id           = "109576666270"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_109576666270_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "109576666270"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_140184854818_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "140184854818"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_140184854818_9458e448-b001-7092-b57c-869b29ecbc05" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "9458e448-b001-7092-b57c-869b29ecbc05"
  principal_type      = "GROUP"
  target_id           = "140184854818"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_211125763900_9458e448-b001-7092-b57c-869b29ecbc05" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "9458e448-b001-7092-b57c-869b29ecbc05"
  principal_type      = "GROUP"
  target_id           = "211125763900"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_267762668325_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "267762668325"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_339712898296_9458e448-b001-7092-b57c-869b29ecbc05" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "9458e448-b001-7092-b57c-869b29ecbc05"
  principal_type      = "GROUP"
  target_id           = "339712898296"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_364170696417_74c864e8-60c1-702d-fd70-9dab53377ac9" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "74c864e8-60c1-702d-fd70-9dab53377ac9"
  principal_type      = "USER"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_364170696417_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_364170696417_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_546106908048_9458e448-b001-7092-b57c-869b29ecbc05" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "9458e448-b001-7092-b57c-869b29ecbc05"
  principal_type      = "GROUP"
  target_id           = "546106908048"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_546106908048_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "546106908048"
}

resource "aws_ssoadmin_account_assignment" "AWSOrganizationsFullAccess_693088575159_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-22059c0a43a504e2"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "693088575159"
}

resource "aws_ssoadmin_permission_set" "manageinstances" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "manageinstances"
  description         = "Manage EC2 instances"
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_account_assignment" "manageinstances_364170696417_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-b326ca03de87e099"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "manageinstances_962265335633_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-b326ca03de87e099"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "962265335633"
}

resource "aws_ssoadmin_account_assignment" "manageinstances_962265335633_74c864e8-60c1-702d-fd70-9dab53377ac9" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-b326ca03de87e099"
  principal_id        = "74c864e8-60c1-702d-fd70-9dab53377ac9"
  principal_type      = "USER"
  target_id           = "962265335633"
}

resource "aws_ssoadmin_account_assignment" "manageinstances_962265335633_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-b326ca03de87e099"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "962265335633"
}

resource "aws_ssoadmin_account_assignment" "manageinstances_962265335633_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-b326ca03de87e099"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "962265335633"
}

resource "aws_ssoadmin_permission_set" "AWSAdministratorAccess" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "AWSAdministratorAccess"
  description         = "Provides full access to AWS services and resources"
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_025651520535_54e8c448-f041-70ec-09c4-3f678af9c08a" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54e8c448-f041-70ec-09c4-3f678af9c08a"
  principal_type      = "USER"
  target_id           = "025651520535"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_025651520535_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "025651520535"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_109576666270_946894b8-c091-70ba-7953-1bde52b94192" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "946894b8-c091-70ba-7953-1bde52b94192"
  principal_type      = "USER"
  target_id           = "109576666270"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_109576666270_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "109576666270"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_140184854818_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "140184854818"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_140184854818_b4783468-10c1-70bc-23d0-0638cf8ad914" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "b4783468-10c1-70bc-23d0-0638cf8ad914"
  principal_type      = "USER"
  target_id           = "140184854818"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_211125763900_94e81458-b001-70da-9ce2-973447eefae7" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "94e81458-b001-70da-9ce2-973447eefae7"
  principal_type      = "USER"
  target_id           = "211125763900"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_267762668325_14b844e8-20b1-70ca-e44f-66e8f8238951" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "14b844e8-20b1-70ca-e44f-66e8f8238951"
  principal_type      = "GROUP"
  target_id           = "267762668325"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_267762668325_9458e448-b001-7092-b57c-869b29ecbc05" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "9458e448-b001-7092-b57c-869b29ecbc05"
  principal_type      = "GROUP"
  target_id           = "267762668325"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_267762668325_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "267762668325"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_267762668325_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "267762668325"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_339712898296_641854f8-9081-703c-7d92-298e90c7d6fc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "641854f8-9081-703c-7d92-298e90c7d6fc"
  principal_type      = "USER"
  target_id           = "339712898296"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_364170696417_9458e448-b001-7092-b57c-869b29ecbc05" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "9458e448-b001-7092-b57c-869b29ecbc05"
  principal_type      = "GROUP"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_364170696417_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_433803933728_9458e448-b001-7092-b57c-869b29ecbc05" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "9458e448-b001-7092-b57c-869b29ecbc05"
  principal_type      = "GROUP"
  target_id           = "433803933728"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_433803933728_c40884c8-5031-708f-a895-755c640bd185" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "c40884c8-5031-708f-a895-755c640bd185"
  principal_type      = "GROUP"
  target_id           = "433803933728"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_433803933728_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "433803933728"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_546106908048_44883458-0081-703b-ae93-be4829fe4c5a" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "44883458-0081-703b-ae93-be4829fe4c5a"
  principal_type      = "USER"
  target_id           = "546106908048"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_546106908048_54982478-c051-701f-4857-bfa4cff28640" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54982478-c051-701f-4857-bfa4cff28640"
  principal_type      = "USER"
  target_id           = "546106908048"
}

resource "aws_ssoadmin_account_assignment" "AWSAdministratorAccess_693088575159_54f8e4e8-4071-708e-b017-5998be4029cc" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-f80918fde3a2653f"
  principal_id        = "54f8e4e8-4071-708e-b017-5998be4029cc"
  principal_type      = "USER"
  target_id           = "693088575159"
}

resource "aws_ssoadmin_permission_set" "AWSReadOnlyAccess" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  name                = "AWSReadOnlyAccess"
  description         = "This policy grants permissions to view resources and basic metadata across all AWS services"
  relay_state         = ""
  session_duration    = "PT1H"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_025651520535_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "025651520535"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_109576666270_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "109576666270"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_140184854818_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "140184854818"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_211125763900_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "211125763900"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_267762668325_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "267762668325"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_339712898296_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "339712898296"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_364170696417_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "364170696417"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_433803933728_0488b4b8-9041-700e-3314-cbbcf282c4d9" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "0488b4b8-9041-700e-3314-cbbcf282c4d9"
  principal_type      = "GROUP"
  target_id           = "433803933728"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_433803933728_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "433803933728"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_546106908048_f468b4a8-8081-7052-5b17-ea0e2b5087eb" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "f468b4a8-8081-7052-5b17-ea0e2b5087eb"
  principal_type      = "GROUP"
  target_id           = "546106908048"
}

resource "aws_ssoadmin_account_assignment" "AWSReadOnlyAccess_693088575159_a4988408-d091-7000-50c3-a2de78d87f7e" {
  instance_arn        = "arn:aws:sso:::instance/ssoins-7223c2272285c157"
  permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-7223c2272285c157/ps-4d20d671687bb396"
  principal_id        = "a4988408-d091-7000-50c3-a2de78d87f7e"
  principal_type      = "GROUP"
  target_id           = "693088575159"
}
