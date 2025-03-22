module "project_factories" {
  source = "./components/project-factory"

  for_each = local.project_configs

  project_key  = each.key
  project_name = each.value.name
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

module "network_factories" {
  source = "./components/network-factory"

  for_each = {
    for key, config in local.project_configs : key => config
    if lookup(config, "network", null) != null
  }

  project_name = each.value.name
  environments = each.value.environments
  location     = each.value.location

  # Convert from separate maps to a single map with all environments
  resource_groups = {
    for env_name, rg in merge(
      module.project_factories[each.key].non_prod_resource_groups,
      module.project_factories[each.key].prod_resource_groups
    ) : env_name => rg
  }

  network_config = each.value.network

  tags = lookup(each.value, "tags", {})

  providers = {
    azurerm.non_prod = azurerm.non_prod
    azurerm.prod     = azurerm.prod
    azurerm.mgmt     = azurerm.mgmt
  }

  depends_on = [module.project_factories]
}

module "security_factories" {
  source = "./components/security-factory"

  for_each = {
    for key, config in local.project_configs : key => config
    if lookup(config, "security", null) != null &&
    lookup(config, "network", null) != null
  }

  project_name = each.value.name
  environments = each.value.environments
  location     = each.value.location

  resource_groups = {
    for env_name, rg in merge(
      module.project_factories[each.key].non_prod_resource_groups,
      module.project_factories[each.key].prod_resource_groups
    ) : env_name => rg
  }

  subnet_ids = {
    non_prod = module.network_factories[each.key].non_prod_subnet_ids
    prod     = module.network_factories[each.key].prod_subnet_ids
  }

  security_config = each.value.security
  tags            = lookup(each.value, "tags", {})

  providers = {
    azurerm.non_prod = azurerm.non_prod
    azurerm.prod     = azurerm.prod
    azurerm.mgmt     = azurerm.mgmt
  }

  depends_on = [module.network_factories]
}