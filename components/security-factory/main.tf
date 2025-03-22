module "non_prod_nsgs" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/network-security-group?ref=1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd"

  for_each = local.non_prod_nsg_configs

  name                = each.value.name
  environment         = each.value.environment
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  security_rules = each.value.rules
  tags           = each.value.additional_tags

  providers = {
    azurerm = azurerm.non_prod
  }
}

module "prod_nsgs" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/network-security-group?ref=1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd"

  for_each = local.prod_nsg_configs

  name                = each.value.name
  environment         = each.value.environment
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  security_rules = each.value.rules
  tags           = each.value.additional_tags

  providers = {
    azurerm = azurerm.prod
  }
}

resource "azurerm_subnet_network_security_group_association" "non_prod" {
  for_each = local.non_prod_subnet_associations

  subnet_id                 = each.value.subnet_id
  network_security_group_id = module.non_prod_nsgs[each.value.nsg_key].id
}

resource "azurerm_subnet_network_security_group_association" "prod" {
  for_each = local.prod_subnet_associations

  subnet_id                 = each.value.subnet_id
  network_security_group_id = module.prod_nsgs[each.value.nsg_key].id
}
