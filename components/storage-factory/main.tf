module "terraform_containers" {
  source = "git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/storage-container?ref=82ef4f2b0bec8d2b608a18197ca941d986264987"

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
