output "tfc_project" {
  description = "TFC project vars."
  value = {
    id                   = tfe_project.this.id
    name                 = tfe_project.this.name
    org_name             = data.tfe_organization.org.name
    oidc_variable_set_id = tfe_variable_set.this.id
    role_arn             = aws_iam_role.project_role.arn
  }
}

output "gitlab_group" {
  description = "Gitlab group vars."
  value = {
    id        = gitlab_group.this.id
    web_url   = gitlab_group.this.web_url
    full_path = gitlab_group.this.full_path
  }
}
