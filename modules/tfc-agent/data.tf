# this is needed so we can get the right root block device name
data "aws_ami" "ami" {
  owners = [data.aws_caller_identity.current.account_id]
  filter {
    name   = "image-id"
    values = [var.Ec2ServerAmi]
  }
}

data "aws_iam_policy" "ssm_policy" {
  name = "AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "cw_logs" {
  name = "CloudWatchAgentServerPolicy"
}

data "aws_caller_identity" "current" {}
