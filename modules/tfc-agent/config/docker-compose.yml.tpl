---
name: terraform-cloud-agent
services:
  tfc-agent:
    image: ${tfc_agent_img_name}:${tfc_agent_img_verion}
    container_name: ${tfc_agent_name}
    environment:
      TFC_AGENT_TOKEN: ${token}
      TFC_AGENT_NAME: ${tfc_agent_name}
      TFC_AGENT_AUTO_UPDATE: ${tfc_agent_auto_update}
      TFC_AGENT_LOG_LEVEL: "TRACE"
    volumes:
      - type: bind
        source: /var/run/docker.sock
        target: /run/docker.sock
    group_add:
      - $docker_group
    logging:
      driver: awslogs
      options:
        awslogs-region: ${region}
        awslogs-group: ${cw_lg_name}
