locals {
  project_files = fileset("${path.module}/projects", "*.yml")
  projects = {
    for file in local.project_files :
    trimsuffix(basename(file), ".yml") => yamldecode(file("${path.module}/projects/${file}"))
  }

  subscriptions_map = merge([
    for project in values(local.projects) :
    project.subscriptions if can(project.subscriptions)
  ]...)

  config = {
    subscriptions = local.subscriptions_map
  }

  project_configs = {
    for project_key, config in local.projects : project_key => {
      name          = config.projectGroupName
      location      = config.location
      subscriptions = config.subscriptions

      env_subscription_map = {
        for env in config.environments :
        env.name => lookup(config.subscriptions, env.subscription_type, null)
      }

      environments_by_subscription_type = {
        for sub_type in distinct([for env in config.environments : env.subscription_type]) :
        sub_type => [
          for env in config.environments :
          env.name if env.subscription_type == sub_type
        ]
      }

      environments = [
        for env in config.environments : {
          name              = env.name
          subscription_type = env.subscription_type
        }
      ]

      # Include network configuration if it exists
      network = lookup(config, "network", null)

      # Include security configuration if it exists  
      security = lookup(config, "security", null)

      # Include any additional top-level configuration keys
      # tags = lookup(config, "tags", {})
      # adminGroupAccess = lookup(config, "adminGroupAccess", null)
      # projectGroupAccess = lookup(config, "projectGroupAccess", null)
    }
  }
}