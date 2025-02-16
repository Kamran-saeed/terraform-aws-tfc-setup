data "aws_caller_identity" "current" {}

data "tfe_organization" "org" {
  name = var.tfc_org_name
}

resource "tfe_project" "this" {
  organization = data.tfe_organization.org.name
  name         = var.tfc_project_name
}

resource "tfe_variable_set" "this" {
  name         = "${upper(replace(var.tfc_project_name, "-", "_"))}_TFE_OIDC_VARS"
  description  = "${var.tfc_project_name} vars to assume role for auth in AWS/Azure."
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "TFC_AWS_RUN_ROLE_ARN" {
  key             = "TFC_AWS_RUN_ROLE_ARN"
  value           = aws_iam_role.project_role.arn
  category        = "env"
  description     = "Role ARN for OIDC flow to authenticate in AWS."
  variable_set_id = tfe_variable_set.this.id
}

resource "tfe_variable" "TFC_WORKLOAD_IDENTITY_AUDIENCE" {
  key             = "TFC_WORKLOAD_IDENTITY_AUDIENCE"
  value           = "aws.workload.identity"
  category        = "env"
  description     = "Audience for the OIDC flow."
  variable_set_id = tfe_variable_set.this.id
}

resource "gitlab_group" "this" {
  name        = var.tfc_project_name
  path        = var.tfc_project_name
  parent_id   = var.gitlab_group_parent_id
  description = var.gitlab_group_description
}
