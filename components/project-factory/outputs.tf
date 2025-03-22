output "non_prod_resource_groups" {
  description = "The resource group objects for non-production environments."
  value = {
    for env, rg in module.non_prod_resource_groups : env => {
      name     = rg.name
      id       = rg.id
      location = var.location
    }
  }
}

output "prod_resource_groups" {
  description = "The resource group objects for the production environment."
  value = {
    for env, rg in module.prod_resource_groups : env => {
      name     = rg.name
      id       = rg.id
      location = var.location
    }
  }
}
