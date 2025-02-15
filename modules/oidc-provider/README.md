# AWS IAM OIDC Provider

AWS IAM OIDC Provider

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 5.0  |
| <a name="requirement_tls"></a> [tls](#requirement_tls)                   | 4.0.5   |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 5.0  |
| <a name="provider_tls"></a> [tls](#provider_tls) | 4.0.5   |

## Modules

No modules.

## Resources

| Name                                                                                                                                                    | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_openid_connect_provider.tfc_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource    |
| [tls_certificate.tfc_certificate](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/data-sources/certificate)                            | data source |

## Inputs

| Name                                                                                                               | Description                                                                                                      | Type           | Default               | Required |
| ------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------- | -------------- | --------------------- | :------: |
| <a name="input_oidc_provider_url"></a> [oidc_provider_url](#input_oidc_provider_url)                               | Name of the oidc provider                                                                                        | `string`       | `"oidc_provider_url"` |    no    |
| <a name="input_tfc_oidc_provider_audiences"></a> [tfc_oidc_provider_audiences](#input_tfc_oidc_provider_audiences) | List of TFC OIDC Provider audiences. This is part of the security configuration between TFC and your AWS account | `list(string)` | `[]`                  |    no    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
