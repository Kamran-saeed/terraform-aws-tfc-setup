resource "aws_iam_openid_connect_provider" "tfc_provider" {
  url            = var.oidc_provider_url
  client_id_list = var.tfc_oidc_provider_audiences
  thumbprint_list = [
    data.tls_certificate.tfc_certificate.certificates[0].sha1_fingerprint,
  ]
}
