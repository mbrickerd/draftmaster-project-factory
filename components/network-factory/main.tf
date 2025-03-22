module "non_prod_vnets" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/virtual-network?ref=1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd"

  for_each = {
    for env in local.non_prod_environments : env => var.network_config.non_prod
    if env != "" && var.network_config.non_prod != null
  }

  name                = local.non_prod_vnet_names[each.key]
  environment         = each.key
  resource_group_name = local.non_prod_resource_groups[each.key].name
  location            = var.location
  address_space       = each.value.address_space

  encryption = {
    enforcement = "AllowUnencrypted"
  }

  flow_timeout_in_minutes = 4
  tags                    = local.tags[each.key]

  providers = {
    azurerm = azurerm.non_prod
  }
}

module "prod_vnets" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/virtual-network?ref=1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd"

  for_each = {
    for env in local.prod_environments : env => var.network_config.prod
    if env != "" && var.network_config.prod != null
  }

  name                = local.prod_vnet_names[each.key]
  environment         = each.key
  resource_group_name = local.prod_resource_groups[each.key].name
  location            = var.location
  address_space       = each.value.address_space

  encryption = {
    enforcement = "AllowUnencrypted"
  }

  flow_timeout_in_minutes = 4
  tags                    = local.tags[each.key]

  providers = {
    azurerm = azurerm.prod
  }
}

module "non_prod_subnets" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/subnet?ref=1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd"

  for_each = {
    for config in local.non_prod_subnet_configs : config.key => config
  }

  name                 = each.value.subnet_name
  resource_group_name  = local.non_prod_resource_groups[each.value.vnet_key].name
  virtual_network_name = module.non_prod_vnets[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
  delegations          = each.value.delegations

  providers = {
    azurerm = azurerm.non_prod
  }

  depends_on = [module.non_prod_vnets]
}

module "prod_subnets" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/subnet?ref=1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd"

  for_each = {
    for config in local.prod_subnet_configs : config.key => config
  }

  name                 = each.value.subnet_name
  resource_group_name  = local.prod_resource_groups[each.value.vnet_key].name
  virtual_network_name = module.prod_vnets[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
  delegations          = each.value.delegations

  providers = {
    azurerm = azurerm.prod
  }

  depends_on = [module.prod_vnets]
}
