<!-- BEGIN_TF_DOCS -->

# TFC Agent

Agent Module for TFC

## Requirements

| Name      | Version  |
| --------- | -------- |
| aws       | >= 5.0   |
| cloudinit | >= 2.0.0 |
| tfe       | 0.57.1   |

## Modules

No modules.

## Resources

| Name                                                                                                                                                      | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_autoscaling_group.cloud-agent-asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)                    | resource    |
| [aws_autoscaling_schedule.tfc-agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule)                    | resource    |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)                         | resource    |
| [aws_iam_instance_profile.cloud-agent-instance-profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource    |
| [aws_iam_role.cloud-agent-ec2-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                 | resource    |
| [aws_iam_role_policy_attachment.cw_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)          | resource    |
| [aws_iam_role_policy_attachment.ssm-managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)      | resource    |
| [aws_launch_template.cloud-agent-launch-template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)            | resource    |
| [aws_security_group.cloud-agent-security-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)               | resource    |
| [tfe_agent_pool.agent-pool](https://registry.terraform.io/providers/hashicorp/tfe/0.57.1/docs/resources/agent_pool)                                       | resource    |
| [tfe_agent_token.agent-token](https://registry.terraform.io/providers/hashicorp/tfe/0.57.1/docs/resources/agent_token)                                    | resource    |
| [aws_ami.ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)                                                         | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                             | data source |
| [aws_iam_policy.cw_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy)                                       | data source |
| [aws_iam_policy.ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy)                                    | data source |
| [cloudinit_config.this](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config)                                      | data source |

## Inputs

| Name                       | Description                                                                                   | Type           | Default                 | Required |
| -------------------------- | --------------------------------------------------------------------------------------------- | -------------- | ----------------------- | :------: |
| AsgMaxSize                 | Maximum number of instances to run in autoscaling group.                                      | `number`       | n/a                     |   yes    |
| AsgMinSize                 | Minimum number of instances to run in autoscaling group.                                      | `number`       | n/a                     |   yes    |
| AsgSubnetIds               | Subnet Ids in which autoscaling group should launch instances.                                | `list(string)` | n/a                     |   yes    |
| DesiredCount               | Desired number of instances to run in autoscaling group.                                      | `number`       | n/a                     |   yes    |
| Ec2RootVolumeSize          | Size of EC2 root volume.                                                                      | `number`       | n/a                     |   yes    |
| Ec2RootVolumeType          | Type of EC2 root volume.                                                                      | `string`       | n/a                     |   yes    |
| Ec2ServerAmi               | AMI for EC2 instance.                                                                         | `string`       | n/a                     |   yes    |
| Ec2ServerInstanceType      | Instance type for EC2 instance.                                                               | `string`       | n/a                     |   yes    |
| ImageName                  | Name of the docker image                                                                      | `string`       | `"hashicorp/tfc-agent"` |    no    |
| ImageVersion               | Version of the docker image.                                                                  | `string`       | n/a                     |   yes    |
| MinimumHealthyPercent      | Mininum number of instances that should be healthy before ASG can refresh any instances       | `number`       | n/a                     |   yes    |
| Region                     | AWS Region                                                                                    | `string`       | n/a                     |   yes    |
| VpcId                      | ID of the VPC.                                                                                | `string`       | n/a                     |   yes    |
| agent_pool_org_name        | Name of the organization of agent pools                                                       | `string`       | n/a                     |   yes    |
| auto_update                | update strategy for the agents. By default, agents will auto update to the last minor version | `string`       | `"minor"`               |    no    |
| env                        | Name for Environment.                                                                         | `string`       | n/a                     |   yes    |
| logging_retention_in_days  | The logging retention in days                                                                 | `number`       | `1`                     |    no    |
| service_name               | service name for the agents                                                                   | `string`       | n/a                     |   yes    |
| tfc_agent_scaling_schedule | scheduling actions map                                                                        | `map(string)`  | `{}`                    |    no    |
| tfc_metrics                | tfc agent metrics                                                                             | `map(string)`  | n/a                     |   yes    |

## Outputs

| Name          | Description                    |
| ------------- | ------------------------------ |
| agent_pool_id | n/a                            |
| asg_name      | Name of the Auto Scaling Group |

<!-- END_TF_DOCS -->
