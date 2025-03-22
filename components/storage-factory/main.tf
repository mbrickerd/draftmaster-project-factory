module "terraform_storage_containers" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/storage-container?ref=1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd"

  for_each = {
    for env in var.environments : env.name => env
  }

  name                  = local.container_names[each.key]
  storage_account_id    = local.storage_account_id
  container_access_type = "private"
  metadata              = {}

  encryption_scope_override_enabled = true

  providers = {
    azurerm = azurerm.mgmt
  }
}
