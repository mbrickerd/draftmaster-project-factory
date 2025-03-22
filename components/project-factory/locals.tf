locals {
  common_tags = {
    managed_by_terraform = true
    project_key          = var.project_key
  }

  environment_tags = {
    for env in var.environments : env.name => {
      environment = env.name
    }
  }

  tags = {
    for env in var.environments : env.name => merge(
      local.common_tags,
      local.environment_tags[env.name],
      lookup(var.tags, env.name, {})
    )
  }
}
