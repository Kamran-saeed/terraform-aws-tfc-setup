########################################################################
# Agent Pool
########################################################################
resource "tfe_agent_pool" "agent-pool" {
  name         = local.agent_name
  organization = var.agent_pool_org_name
}

resource "tfe_agent_token" "agent-token" {
  agent_pool_id = tfe_agent_pool.agent-pool.id
  description   = "${local.agent_name}-token"
}
