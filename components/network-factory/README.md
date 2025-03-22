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
| <a name="module_non_prod_subnets"></a> [non\_prod\_subnets](#module\_non\_prod\_subnets) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/subnet | 1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd |
| <a name="module_non_prod_vnets"></a> [non\_prod\_vnets](#module\_non\_prod\_vnets) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/virtual-network | 1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd |
| <a name="module_prod_subnets"></a> [prod\_subnets](#module\_prod\_subnets) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/subnet | 1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd |
| <a name="module_prod_vnets"></a> [prod\_vnets](#module\_prod\_vnets) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/virtual-network | 1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | A list of environments with their subscription types. | <pre>list(object({<br/>    name              = string<br/>    subscription_type = string<br/>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created. | `string` | `"westeurope"` | no |
| <a name="input_network_config"></a> [network\_config](#input\_network\_config) | The network configuration for different subscription types. | <pre>object({<br/>    non_prod = optional(object({<br/>      address_space = list(string)<br/>      subnets = map(object({<br/>        address_prefixes  = list(string)<br/>        service_endpoints = optional(list(string), [])<br/>        delegations = optional(list(object({<br/>          name = string<br/>          service_delegation = object({<br/>            name    = string<br/>            actions = optional(list(string))<br/>          })<br/>        })), [])<br/>        private_endpoint_network_policies = optional(string, "Disabled")<br/>      }))<br/>    }))<br/>    prod = optional(object({<br/>      address_space = list(string)<br/>      subnets = map(object({<br/>        address_prefixes  = list(string)<br/>        service_endpoints = optional(list(string), [])<br/>        delegations = optional(list(object({<br/>          name = string<br/>          service_delegation = object({<br/>            name    = string<br/>            actions = optional(list(string))<br/>          })<br/>        })), [])<br/>        private_endpoint_network_policies = optional(string, "Disabled")<br/>      }))<br/>    }))<br/>  })</pre> | <pre>{<br/>  "non_prod": null,<br/>  "prod": null<br/>}</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project (derived from YAML config). | `string` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | A mapping of environment names to resource group objects. | <pre>map(object({<br/>    name     = string<br/>    id       = string<br/>    location = string<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to apply to all resources. | `map(map(string))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_non_prod_subnet_ids"></a> [non\_prod\_subnet\_ids](#output\_non\_prod\_subnet\_ids) | A mapping of non-production subnet IDs by environment and subnet name. |
| <a name="output_non_prod_subnet_names"></a> [non\_prod\_subnet\_names](#output\_non\_prod\_subnet\_names) | A mapping of non-production subnet names by environment. |
| <a name="output_non_prod_vnet_ids"></a> [non\_prod\_vnet\_ids](#output\_non\_prod\_vnet\_ids) | A mapping of non-production virtual network IDs by environment. |
| <a name="output_non_prod_vnet_names"></a> [non\_prod\_vnet\_names](#output\_non\_prod\_vnet\_names) | A mapping of non-production virtual network names by environment. |
| <a name="output_prod_subnet_ids"></a> [prod\_subnet\_ids](#output\_prod\_subnet\_ids) | A mapping of production subnet IDs by environment and subnet name. |
| <a name="output_prod_subnet_names"></a> [prod\_subnet\_names](#output\_prod\_subnet\_names) | A mapping of production subnet names by environment. |
| <a name="output_prod_vnet_ids"></a> [prod\_vnet\_ids](#output\_prod\_vnet\_ids) | A mapping of production virtual network IDs by environment. |
| <a name="output_prod_vnet_names"></a> [prod\_vnet\_names](#output\_prod\_vnet\_names) | A mapping of production virtual network names by environment. |
<!-- END_TF_DOCS -->
