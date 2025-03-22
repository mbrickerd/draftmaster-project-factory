<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_non_prod_nsgs"></a> [non\_prod\_nsgs](#module\_non\_prod\_nsgs) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/network-security-group | 1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd |
| <a name="module_prod_nsgs"></a> [prod\_nsgs](#module\_prod\_nsgs) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/network-security-group | 1c15e1bdf86e0b20b6a2669cf860ad16265dd5fd |

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet_network_security_group_association.non_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | A list of environments with their subscription types. | <pre>list(object({<br/>    name              = string<br/>    subscription_type = string<br/>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where resources will be created. | `string` | `"westeurope"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project (derived from YAML config). | `string` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | A mapping of environment names to resource group objects. | <pre>map(object({<br/>    name     = string<br/>    id       = string<br/>    location = string<br/>  }))</pre> | n/a | yes |
| <a name="input_security_config"></a> [security\_config](#input\_security\_config) | The security configuration including network security groups. | <pre>object({<br/>    network_security_groups = optional(object({<br/>      non_prod = optional(map(object({<br/>        rules = list(object({<br/>          name                         = string<br/>          priority                     = number<br/>          direction                    = string<br/>          access                       = string<br/>          protocol                     = string<br/>          source_port_range            = optional(string)<br/>          source_port_ranges           = optional(list(string))<br/>          source_address_prefix        = optional(string)<br/>          source_address_prefixes      = optional(list(string))<br/>          destination_port_range       = optional(string)<br/>          destination_port_ranges      = optional(list(string))<br/>          destination_address_prefix   = optional(string)<br/>          destination_address_prefixes = optional(list(string))<br/>          description                  = optional(string, "")<br/>        }))<br/>      })), {})<br/>      prod = optional(map(object({<br/>        rules = list(object({<br/>          name                         = string<br/>          priority                     = number<br/>          direction                    = string<br/>          access                       = string<br/>          protocol                     = string<br/>          source_port_range            = optional(string)<br/>          source_port_ranges           = optional(list(string))<br/>          source_address_prefix        = optional(string)<br/>          source_address_prefixes      = optional(list(string))<br/>          destination_port_range       = optional(string)<br/>          destination_port_ranges      = optional(list(string))<br/>          destination_address_prefix   = optional(string)<br/>          destination_address_prefixes = optional(list(string))<br/>          description                  = optional(string, "")<br/>        }))<br/>      })), {})<br/>    }), {})<br/>  })</pre> | <pre>{<br/>  "network_security_groups": {}<br/>}</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A mapping of subnet IDs by subscription type and environment. | <pre>object({<br/>    non_prod = map(map(string))<br/>    prod     = map(map(string))<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to apply to all resources. | `map(map(string))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_non_prod_nsg_ids"></a> [non\_prod\_nsg\_ids](#output\_non\_prod\_nsg\_ids) | A mapping of non-production network security group IDs by environment and subnet name. |
| <a name="output_non_prod_subnet_nsg_associations"></a> [non\_prod\_subnet\_nsg\_associations](#output\_non\_prod\_subnet\_nsg\_associations) | A mapping of non-production subnet to NSG associations. |
| <a name="output_prod_nsg_ids"></a> [prod\_nsg\_ids](#output\_prod\_nsg\_ids) | A mapping of production network security group IDs by environment and subnet name. |
| <a name="output_prod_subnet_nsg_associations"></a> [prod\_subnet\_nsg\_associations](#output\_prod\_subnet\_nsg\_associations) | A mapping of production subnet to NSG associations. |
<!-- END_TF_DOCS -->
