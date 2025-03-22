<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform_storage_containers"></a> [terraform\_storage\_containers](#module\_terraform\_storage\_containers) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/storage-container | 1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | A list of environments with their subscription types. | <pre>list(object({<br/>    name              = string<br/>    subscription_type = string<br/>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project (derived from YAML config). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_non_prod_storage_containers"></a> [non\_prod\_storage\_containers](#output\_non\_prod\_storage\_containers) | A mapping of non-production storage containers. |
| <a name="output_prod_storage_containers"></a> [prod\_storage\_containers](#output\_prod\_storage\_containers) | A mapping of production storage containers. |
<!-- END_TF_DOCS -->
