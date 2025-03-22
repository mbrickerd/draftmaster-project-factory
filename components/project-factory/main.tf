module "non_prod_resource_groups" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/resource-group?ref=1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd"

  for_each = {
    for env in var.environments : env.name => env
    if env.subscription_type != "prod"
  }

  name        = var.project_name
  environment = each.key
  location    = var.location
  tags        = local.tags[each.key]

  providers = {
    azurerm = azurerm.non_prod
  }
}

module "prod_resource_groups" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/resource-group?ref=1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd"

  for_each = {
    for env in var.environments : env.name => env
    if env.subscription_type == "prod"
  }

  name        = var.project_name
  environment = each.key
  location    = var.location
  tags        = local.tags[each.key]

  providers = {
    azurerm = azurerm.prod
  }
}
