# AWS IAM OIDC Provider

AWS IAM OIDC Provider

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 4.0  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 4.0  |
| <a name="provider_tls"></a> [tls](#provider_tls) | n/a     |

## Modules

| Name                                                                                                              | Source                                                              | Version  |
| ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- | -------- |
| <a name="module_tfc_workload_identity_role"></a> [tfc_workload_identity_role](#module_tfc_workload_identity_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | ~> 5.3.0 |

## Resources

| Name                                                                                                                                                    | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_openid_connect_provider.tfc_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource    |
| [aws_iam_policy.identity_provider_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)           | resource    |
| [aws_iam_policy.aws_administrator_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy)                    | data source |
| [tls_certificate.tfc_certificate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate)                           | data source |

## Inputs

| Name                                                                                                                                                                                       | Description                                                                                                      | Type                                                                                                                  | Default                               | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | ------------------------------------- | :------: |
| <a name="input_assume_role_arns"></a> [assume_role_arns](#input_assume_role_arns)                                                                                                          | List of assume role arns to add to oidc role                                                                     | `list(string)`                                                                                                        | `[]`                                  |    no    |
| <a name="input_create_tfc_oidc_provider"></a> [create_tfc_oidc_provider](#input_create_tfc_oidc_provider)                                                                                  | Create TFC OIDC Provider. Only one can exist in an account                                                       | `bool`                                                                                                                | `true`                                |    no    |
| <a name="input_create_tfc_workload_identity_role"></a> [create_tfc_workload_identity_role](#input_create_tfc_workload_identity_role)                                                       | Create IAM Role for TFC Workload Identity                                                                        | `bool`                                                                                                                | `true`                                |    no    |
| <a name="input_environment"></a> [environment](#input_environment)                                                                                                                         | organization for which the role is being created                                                                 | `string`                                                                                                              | `""`                                  |    no    |
| <a name="input_oidc_provider_url"></a> [oidc_provider_url](#input_oidc_provider_url)                                                                                                       | Name of the oidc provider                                                                                        | `string`                                                                                                              | `"oidc_provider_url"`                 |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                                                                              | List of tags for resources                                                                                       | `map(string)`                                                                                                         | `{}`                                  |    no    |
| <a name="input_tfc_oidc_provider_audiences"></a> [tfc_oidc_provider_audiences](#input_tfc_oidc_provider_audiences)                                                                         | List of TFC OIDC Provider audiences. This is part of the security configuration between TFC and your AWS account | `list(string)`                                                                                                        | `[]`                                  |    no    |
| <a name="input_tfc_org_name"></a> [tfc_org_name](#input_tfc_org_name)                                                                                                                      | organization for which the role is being created                                                                 | `string`                                                                                                              | `""`                                  |    no    |
| <a name="input_tfc_workload_identity_role"></a> [tfc_workload_identity_role](#input_tfc_workload_identity_role)                                                                            | Name of the IAM Role for TFC                                                                                     | `string`                                                                                                              | `"TfcWorkloadIdentity"`               |    no    |
| <a name="input_tfc_workload_identity_role_audiences"></a> [tfc_workload_identity_role_audiences](#input_tfc_workload_identity_role_audiences)                                              | List of allowed audiences for the IAM Role. Defaults to the one for the OIDC provider if unspecified.            | `list(string)`                                                                                                        | `[]`                                  |    no    |
| <a name="input_tfc_workload_identity_role_description"></a> [tfc_workload_identity_role_description](#input_tfc_workload_identity_role_description)                                        | Description of the IAM Role for TFC                                                                              | `string`                                                                                                              | `"Terraform Cloud Workload Identity"` |    no    |
| <a name="input_tfc_workload_identity_role_max_session_duration"></a> [tfc_workload_identity_role_max_session_duration](#input_tfc_workload_identity_role_max_session_duration)             | Maximum CLI/API session duration in seconds between 3600 and 43200                                               | `number`                                                                                                              | `3600`                                |    no    |
| <a name="input_tfc_workload_identity_role_permissions_boundary_arn"></a> [tfc_workload_identity_role_permissions_boundary_arn](#input_tfc_workload_identity_role_permissions_boundary_arn) | Permissions boundary ARN to use for IAM role for TFC                                                             | `string`                                                                                                              | `""`                                  |    no    |
| <a name="input_tfc_workload_identity_role_policy_arns"></a> [tfc_workload_identity_role_policy_arns](#input_tfc_workload_identity_role_policy_arns)                                        | List of ARN to attach the IAM Role for TFC                                                                       | `list(string)`                                                                                                        | `[]`                                  |    no    |
| <a name="input_workload_identity_map"></a> [workload_identity_map](#input_workload_identity_map)                                                                                           | workload identity map for roles to be assumed per project/workspace                                              | <pre>map(map(object(<br> { project = string<br> name = string<br> assume_role_arns = list(string)<br> }<br> )))</pre> | n/a                                   |   yes    |

## Outputs

| Name                                                                                                                          | Description                              |
| ----------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| <a name="output_tfc_workload_identity_audience"></a> [tfc_workload_identity_audience](#output_tfc_workload_identity_audience) | Audience value for TFC workload identity |
| <a name="output_tfc_workload_identity_role_arn"></a> [tfc_workload_identity_role_arn](#output_tfc_workload_identity_role_arn) | IAM Role ARN for TFC Workload Identity   |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.tfc_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [tls_certificate.tfc_certificate](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oidc_provider_url"></a> [oidc\_provider\_url](#input\_oidc\_provider\_url) | Name of the oidc provider | `string` | `"oidc_provider_url"` | no |
| <a name="input_tfc_oidc_provider_audiences"></a> [tfc\_oidc\_provider\_audiences](#input\_tfc\_oidc\_provider\_audiences) | List of TFC OIDC Provider audiences. This is part of the security configuration between TFC and your AWS account | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->