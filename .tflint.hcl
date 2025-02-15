// Usage: tflint --recursive --config=$(pwd)/.tflint.hcl

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

rule "terraform_required_version" {
  enabled = false
}
