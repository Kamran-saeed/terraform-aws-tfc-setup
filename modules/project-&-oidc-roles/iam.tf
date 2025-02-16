resource "aws_iam_role_policy" "project_policy" {
  name = "tfc-${var.tfc_org_name}-${var.tfc_project_name}-oidc-assume-policy"
  role = aws_iam_role.project_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect : "Allow"
        "Resource" : [
          for name, account in var.aws_accounts : "arn:aws:iam::${account.id}:role/tfe-${var.tfc_project_name}-account-assume-role"
        ]
      }
    ],
  })
}

resource "aws_iam_role" "project_role" {
  name = "tfc-${var.tfc_project_name}-oidc-assume-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.tfc_domain}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "${var.tfc_domain}:aud" : "aws.workload.identity",
            "${var.tfc_domain}:sub" : "organization:${data.tfe_organization.org.name}:project:${var.tfc_project_name}:workspace:*:run_phase:*"
          }
        }
      }
    ]
  })
}
