output "non_prod_storage_containers" {
  description = "A mapping of non-production storage containers."
  value = {
    for env in local.non_prod_environments : env => {
      # Fill in actual storage container details here
      # This is a placeholder - replace with actual module outputs
      containers = {}
    }
  }
}

output "prod_storage_containers" {
  description = "A mapping of production storage containers."
  value = {
    for env in local.prod_environments : env => {
      # Fill in actual storage container details here
      # This is a placeholder - replace with actual module outputs
      containers = {}
    }
  }
}
