resource "aws_iam_role_policy" "project_account_policy" {
  name = "tfc-${var.tfc_project.org_name}-${var.tfc_project.name}-account-policy"
  role = aws_iam_role.project_account_role.id

  policy = var.policy
}

resource "aws_iam_role" "project_account_role" {
  name = "tfc-${var.tfc_project.name}-account-assume-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow",
      Principal = {
        AWS = var.tfc_project.role_arn
      },
      Action = "sts:AssumeRole"
    }]
  })
}
