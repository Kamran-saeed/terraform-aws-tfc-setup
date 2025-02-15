data "tls_certificate" "tfc_certificate" {
  url = var.oidc_provider_url
}
