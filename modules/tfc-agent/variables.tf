variable "VpcId" {
  description = "ID of the VPC."
  type        = string
}

# Parameters within this module
variable "Region" {
  description = "AWS Region"
  type        = string
}

variable "env" {
  description = "Name for Environment."
  type        = string
}

variable "Ec2ServerAmi" {
  description = "AMI for EC2 instance."
  type        = string
}

variable "Ec2ServerInstanceType" {
  description = "Instance type for EC2 instance."
  type        = string
}

variable "Ec2RootVolumeSize" {
  description = "Size of EC2 root volume."
  type        = number
}
variable "Ec2RootVolumeType" {
  description = "Type of EC2 root volume."
  type        = string
}

variable "AsgMinSize" {
  description = "Minimum number of instances to run in autoscaling group."
  type        = number
}

variable "DesiredCount" {
  description = "Desired number of instances to run in autoscaling group."
  type        = number
}

variable "AsgMaxSize" {
  description = "Maximum number of instances to run in autoscaling group."
  type        = number
}

variable "AsgSubnetIds" {
  description = "Subnet Ids in which autoscaling group should launch instances."
  type        = list(string)
}

variable "MinimumHealthyPercent" {
  description = "Mininum number of instances that should be healthy before ASG can refresh any instances"
  type        = number
}

variable "ImageName" {
  description = "Name of the docker image"
  type        = string
  default     = "hashicorp/tfc-agent"
}

variable "ImageVersion" {
  description = "Version of the docker image."
  type        = string
}

variable "agent_pool_org_name" {
  description = "Name of the organization of agent pools"
  type        = string
}

variable "service_name" {
  description = "service name for the agents"
  type        = string
}

variable "auto_update" {
  description = "update strategy for the agents. By default, agents will auto update to the last minor version"
  type        = string
  default     = "minor"
}

variable "logging_retention_in_days" {
  description = "The logging retention in days"
  type        = number
  default     = 1
}

variable "tfc_agent_scaling_schedule" {
  type        = map(string)
  description = "scheduling actions map"
  default     = {}
}
