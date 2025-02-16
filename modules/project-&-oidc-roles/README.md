# project module

Module to create projects in Terraform Cloud. All projects are linked to a gitlab sub-group.

In addition it creates the IAM role to assume for the project workspace.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | >= 16.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.44 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | >= 16.0 |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | >= 0.44 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.project_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.project_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [gitlab_group.this](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group) | resource |
| [gitlab_group_membership.application_group_access](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_membership) | resource |
| [tfe_project.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_variable.ARM_SUBSCRIPTION_ID](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.ARM_TENANT_ID](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.TFC_AWS_RUN_ROLE_ARN](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.TFC_AZURE_PROVIDER_AUTH](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.TFC_AZURE_RUN_CLIENT_ID](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.TFC_WORKLOAD_IDENTITY_AUDIENCE](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable_set.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [gitlab_user.group_members](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/user) | data source |
| [tfe_organization.org](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_accounts"></a> [aws\_accounts](#input\_aws\_accounts) | List of accounts the project has access to. | <pre>map(object({<br>    id = string<br>  }))</pre> | `{}` | no |
| <a name="input_azure_application"></a> [azure\_application](#input\_azure\_application) | azure account details to give tfc workspace access to | <pre>object({<br>    subscription_id       = optional(string, "")<br>    tenant_id             = optional(string, "")<br>    application_client_id = optional(string, "")<br>  })</pre> | `{}` | no |
| <a name="input_gitlab_group_description"></a> [gitlab\_group\_description](#input\_gitlab\_group\_description) | The description for gitlab group. | `string` | n/a | yes |
| <a name="input_gitlab_group_members"></a> [gitlab\_group\_members](#input\_gitlab\_group\_members) | The list of members for Gitlab group | `list(string)` | `[]` | no |
| <a name="input_gitlab_group_parent_id"></a> [gitlab\_group\_parent\_id](#input\_gitlab\_group\_parent\_id) | The parent group of the gitlab group to create. | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags that shall be added to all created resources | `map(string)` | `{}` | no |
| <a name="input_tfe_domain"></a> [tfe\_domain](#input\_tfe\_domain) | TFE instance domain. | `string` | n/a | yes |
| <a name="input_tfe_external_workload_identity_role_arn"></a> [tfe\_external\_workload\_identity\_role\_arn](#input\_tfe\_external\_workload\_identity\_role\_arn) | (optional) Pass in an external role for the tfe var set. Will disable the creation of the role in the project. | `string` | `""` | no |
| <a name="input_tfe_org_name"></a> [tfe\_org\_name](#input\_tfe\_org\_name) | The organisation name in TFE which the workspaces are created in. | `string` | n/a | yes |
| <a name="input_tfe_project_name"></a> [tfe\_project\_name](#input\_tfe\_project\_name) | Name of the project in TFE. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gitlab_group"></a> [gitlab\_group](#output\_gitlab\_group) | Gitlab group vars. |
| <a name="output_tfe_project"></a> [tfe\_project](#output\_tfe\_project) | TFE project vars. |
<!-- END_TF_DOCS -->
