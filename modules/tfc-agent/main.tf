locals {
  agent_name = "${var.env}-${var.service_name}-${var.agent_pool_org_name}"
  asg_name   = "${var.env}-${var.service_name}-${var.agent_pool_org_name}-asg"
}

# IAM Role for the ASG
resource "aws_iam_role" "cloud-agent-ec2-role" {
  name                  = "${var.env}-${var.service_name}-${var.agent_pool_org_name}-role"
  description           = "EC2 role to create resources via Terraform"
  force_detach_policies = true
  assume_role_policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm-managed" {
  role = aws_iam_role.cloud-agent-ec2-role.id

  policy_arn = data.aws_iam_policy.ssm_policy.arn
}

resource "aws_iam_role_policy_attachment" "cw_logs" {
  role = aws_iam_role.cloud-agent-ec2-role.id

  policy_arn = data.aws_iam_policy.cw_logs.arn
}

# Cloudwatch Logs Group
resource "aws_cloudwatch_log_group" "this" {
  name              = "/${var.env}/${var.service_name}/${var.agent_pool_org_name}"
  retention_in_days = var.logging_retention_in_days
}

# Create instance profile for ec2 role
resource "aws_iam_instance_profile" "cloud-agent-instance-profile" {
  name = "${var.env}-${var.service_name}-${var.agent_pool_org_name}-insp"
  role = aws_iam_role.cloud-agent-ec2-role.name
}

# Security Group for the Cloud Agent Instances
resource "aws_security_group" "cloud-agent-security-group" {
  name        = "${var.env}-${var.service_name}-${var.agent_pool_org_name}-sg"
  description = "Allow traffic to/from the cloud agent machine"
  vpc_id      = var.VpcId
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.env}-${var.service_name}-${var.agent_pool_org_name}-sg",
    Environment = var.env
  }
}

# Launch Template
resource "aws_launch_template" "cloud-agent-launch-template" {
  name          = "${var.env}-${var.service_name}-${var.agent_pool_org_name}-lt"
  image_id      = var.Ec2ServerAmi
  instance_type = var.Ec2ServerInstanceType

  metadata_options {
    http_tokens = "required"
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.cloud-agent-security-group.id]
    delete_on_termination       = true
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.cloud-agent-instance-profile.name
  }
  block_device_mappings {
    device_name = data.aws_ami.ami.root_device_name

    ebs {
      volume_type           = var.Ec2RootVolumeType
      volume_size           = var.Ec2RootVolumeSize
      delete_on_termination = true
    }
  }
  user_data = data.cloudinit_config.this.rendered
}

# Create autoscaling group for ec2 instances
resource "aws_autoscaling_group" "cloud-agent-asg" {
  name             = local.asg_name
  min_size         = var.AsgMinSize
  desired_capacity = var.DesiredCount
  max_size         = var.AsgMaxSize

  launch_template {
    id      = aws_launch_template.cloud-agent-launch-template.id
    version = aws_launch_template.cloud-agent-launch-template.latest_version
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = var.MinimumHealthyPercent
    }
  }
  vpc_zone_identifier = var.AsgSubnetIds

  tag {
    key                 = "Name"
    value               = local.agent_name
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.env
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_schedule" "tfc-agent" {
  for_each               = var.tfc_agent_scaling_schedule
  scheduled_action_name  = "scaling_schedule_${each.key}"
  desired_capacity       = each.value
  recurrence             = each.key
  min_size               = 0
  max_size               = -1
  autoscaling_group_name = aws_autoscaling_group.cloud-agent-asg.name
  time_zone              = "Europe/Berlin"
}
