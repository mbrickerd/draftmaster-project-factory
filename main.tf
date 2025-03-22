module "project_factories" {
  source = "./components/project-factory"

  for_each = local.project_configs

  project_name = each.value.name
  project_key  = each.key
  location     = each.value.location
  environments = each.value.environments

  providers = {
    azurerm.non_prod = azurerm.non_prod
    azurerm.prod     = azurerm.prod
    azurerm.mgmt     = azurerm.mgmt
  }
}

module "storage_factories" {
  source = "./components/storage-factory"

  for_each     = local.project_configs
  project_name = each.value.name
  environments = each.value.environments

  providers = {
    azurerm.non_prod = azurerm.non_prod
    azurerm.prod     = azurerm.prod
    azurerm.mgmt     = azurerm.mgmt
  }
}
