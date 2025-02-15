variable "tfc_oidc_provider_audiences" {
  description = "List of TFC OIDC Provider audiences. This is part of the security configuration between TFC and your AWS account"
  type        = list(string)
  default     = []
}

variable "oidc_provider_url" {
  description = "Name of the oidc provider"
  type        = string
  default     = "oidc_provider_url"
}
