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
| <a name="module_non_prod_resource_groups"></a> [non\_prod\_resource\_groups](#module\_non\_prod\_resource\_groups) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/resource-group | 1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd |
| <a name="module_prod_resource_groups"></a> [prod\_resource\_groups](#module\_prod\_resource\_groups) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/resource-group | 1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | A list of environments with their subscription types. | <pre>list(object({<br/>    name              = string<br/>    subscription_type = string<br/>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created. | `string` | `"westeurope"` | no |
| <a name="input_project_key"></a> [project\_key](#input\_project\_key) | The key of the project YAML configuration file. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project (derived from YAML config). | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to apply to all resources. | `map(map(string))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_non_prod_resource_groups"></a> [non\_prod\_resource\_groups](#output\_non\_prod\_resource\_groups) | The resource group objects for non-production environments. |
| <a name="output_prod_resource_groups"></a> [prod\_resource\_groups](#output\_prod\_resource\_groups) | The resource group objects for the production environment. |
<!-- END_TF_DOCS -->
