variable "tfc_project" {
  description = "TFC project vars."
  type = object({
    name     = string
    org_name = string
    role_arn = string
  })
}

variable "policy" {
  type        = string
  description = "The inline policy document. This is a JSON formatted string which defines the access right for the policy in AWS."
}
