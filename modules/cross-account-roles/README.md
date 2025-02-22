# Project Account Role module

Module to create roles in AWS account for project workspaces in Terraform Cloud to create resources.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 4.0   |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 4.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                      | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_iam_role.project_account_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                 | resource |
| [aws_iam_role_policy.project_account_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

## Inputs

| Name                                                               | Description                                                                                                       | Type                                                                                     | Default | Required |
| ------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_policy"></a> [policy](#input_policy)                | The inline policy document. This is a JSON formatted string which defines the access right for the policy in AWS. | `string`                                                                                 | n/a     |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                      | Tags that shall be added to all created resources                                                                 | `map(string)`                                                                            | `{}`    |    no    |
| <a name="input_tfe_project"></a> [tfe_project](#input_tfe_project) | TFE project vars.                                                                                                 | <pre>object({<br> name = string<br> org_name = string<br> role_arn = string<br> })</pre> | n/a     |   yes    |

## Outputs

| Name                                                                    | Description              |
| ----------------------------------------------------------------------- | ------------------------ |
| <a name="output_iam_role_arn"></a> [iam_role_arn](#output_iam_role_arn) | The ARN of the IAM role. |

<!-- END_TF_DOCS -->
