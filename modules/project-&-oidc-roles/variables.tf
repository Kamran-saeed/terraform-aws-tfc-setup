variable "tfc_project_name" {
  type        = string
  description = "Name of the project in TFC."
}

variable "tfc_org_name" {
  type        = string
  description = "The organisation name in TFC which the workspaces are created in."
}

variable "tfc_domain" {
  type        = string
  description = "TFC instance domain."
}

variable "aws_accounts" {
  type = map(object({
    id = string
  }))
  description = "List of accounts the project has access to."
  default     = {}
}

variable "gitlab_group_parent_id" {
  type        = number
  description = "The parent group of the gitlab group to create."
}

variable "gitlab_group_description" {
  type        = string
  description = "The description for gitlab group."
}
