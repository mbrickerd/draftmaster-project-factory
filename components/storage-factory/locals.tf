locals {
  storage_account_id = "/subscriptions/7bc4b637-e7b0-4cf5-8105-b46e1c86cb83/resourceGroups/rg-projectfactory-mgmt/providers/Microsoft.Storage/storageAccounts/saprojectfactorymgmt"
  container_names = {
    for env in var.environments : env.name => "${var.project_name}-${env.name}-state"
  }

  non_prod_environments = [
    for env in var.environments : env.name
    if env.subscription_type == "non_prod"
  ]

  prod_environments = [
    for env in var.environments : env.name
    if env.subscription_type == "prod"
  ]
}
