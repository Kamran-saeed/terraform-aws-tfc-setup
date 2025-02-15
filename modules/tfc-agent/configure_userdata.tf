data "cloudinit_config" "this" {
  gzip          = true
  base64_encode = true

  ########################################################################
  # Copy Docker file
  ########################################################################
  part {
    filename     = "/etc/tfc-agent/conf/Dockerfile"
    content_type = "text/jinja2"
    content = templatefile("${path.module}/user_data/put-file.j2.tpl",
      {
        path        = "/etc/tfc-agent/conf/Dockerfile",
        permissions = "0644",
        content = base64encode(templatefile("${path.module}/config/Dockerfile.tpl",
          {
            image_version = var.ImageVersion
          }
        ))
      }
    )
  }
  ########################################################################
  # Copy Pre-Plan Hook

  # When using cloud agents, you will have to add two hooks called pre-plan and pre-apply.
  # The pre-plan hook will run at plan stage and will communicate with OIDC to get the temporary credentials and store them inside the cloud agent machine

  ########################################################################
  part {
    filename     = "/etc/tfc-agent/conf/hooks/terraform-pre-plan"
    content_type = "text/jinja2"
    content = templatefile("${path.module}/user_data/put-file.j2.tpl",
      {
        path        = "/etc/tfc-agent/conf/hooks/terraform-pre-plan",
        permissions = "0755",
        content     = base64encode(templatefile("${path.module}/config/hooks/terraform-pre-plan.tpl", {}))
      }
    )
  }
  ########################################################################
  # Copy Pre-Apply hook

  # Same thing will happen in the pre-apply step which runs during the apply stage.
  ########################################################################
  part {
    filename     = "/etc/tfc-agent/conf/hooks/terraform-pre-apply"
    content_type = "text/jinja2"
    content = templatefile("${path.module}/user_data/put-file.j2.tpl",
      {
        path        = "/etc/tfc-agent/conf/hooks/terraform-pre-apply",
        permissions = "0755",
        content     = base64encode(templatefile("${path.module}/config/hooks/terraform-pre-apply.tpl", {}))
      }
    )
  }
  ########################################################################
  # Copy Docker Compose configuration
  ########################################################################
  part {
    filename     = "docker-compose.yml"
    content_type = "text/jinja2"
    content = templatefile("${path.module}/user_data/put-file.j2.tpl",
      {
        path        = "/etc/tfc-agent/docker-compose.yml",
        permissions = "0644",
        content = base64encode(templatefile("${path.module}/config/docker-compose.yml.tpl",
          {
            region                = var.Region
            cw_lg_name            = aws_cloudwatch_log_group.this.name
            token                 = tfe_agent_token.agent-token.token
            tfc_agent_name        = local.agent_name
            tfc_agent_auto_update = var.auto_update
            tfc_agent_img_name    = var.ImageName
            tfc_agent_img_verion  = var.ImageVersion
          }
        ))
      }
    )
  }
  ########################################################################
  # Configure Userdata
  ########################################################################
  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/user_data/userdata.sh.tpl",
      {
        token            = tfe_agent_token.agent-token.token
        agent_name       = local.agent_name
        region           = var.Region
        image_name       = var.ImageName
        image_version    = var.ImageVersion
        hooks_directory  = "/etc/tfc-agent/conf"
        docker_file_path = "/etc/tfc-agent/conf/Dockerfile"
        service_name     = var.service_name
    })
  }
}
