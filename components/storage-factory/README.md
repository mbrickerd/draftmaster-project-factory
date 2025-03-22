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
| <a name="module_terraform_containers"></a> [terraform\_containers](#module\_terraform\_containers) | git::https://github.com/mbrickerd/terraform-azure-modules.git//modules/storage-container | 82ef4f2b0bec8d2b608a18197ca941d986264987 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | A list of environments with their subscription types. | <pre>list(object({<br/>    name              = string<br/>    subscription_type = string<br/>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project (derived from YAML config). | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
