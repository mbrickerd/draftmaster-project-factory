locals {
  # Get all YAML files in the projects directory
  project_files = fileset("${path.module}/projects", "*.yml")

  # Parse each YAML file
  projects = {
    for file in local.project_files :
    trimsuffix(basename(file), ".yml") => yamldecode(file("${path.module}/projects/${file}"))
  }

  # Extract unique subscription mappings from all projects
  # This creates a merged map of all subscription types across all projects
  subscriptions_map = merge([
    for project in values(local.projects) :
    project.subscriptions if can(project.subscriptions)
  ]...)

  # Create a config object with the merged subscriptions
  config = {
    subscriptions = local.subscriptions_map
  }

  # Rest of your existing code...
  project_configs = {
    for project_key, config in local.projects : project_key => {
      name          = config.projectGroupName
      location      = config.location
      subscriptions = config.subscriptions

      # Create environment-to-subscription mapping for this specific project
      env_subscription_map = {
        for env in config.environments :
        env.name => lookup(config.subscriptions, env.subscription_type, null)
      }

      # Group environments by subscription type for this project
      environments_by_subscription_type = {
        for sub_type in distinct([for env in config.environments : env.subscription_type]) :
        sub_type => [
          for env in config.environments :
          env.name if env.subscription_type == sub_type
        ]
      }

      # List of environments with their subscription types
      environments = [
        for env in config.environments : {
          name              = env.name
          subscription_type = env.subscription_type
        }
      ]
    }
  }
}