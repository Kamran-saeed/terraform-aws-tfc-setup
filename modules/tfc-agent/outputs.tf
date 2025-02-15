output "asg_name" {
  value       = aws_autoscaling_group.cloud-agent-asg.name
  description = "Name of the Auto Scaling Group"
}

output "agent_pool_id" {
  value = tfe_agent_pool.agent-pool.id
}
