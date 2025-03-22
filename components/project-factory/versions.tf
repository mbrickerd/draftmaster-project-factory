terraform {
  required_version = ">= 1.4.2"

  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 4.0"
      configuration_aliases = [azurerm.prod, azurerm.non_prod, azurerm.mgmt]
    }
  }
}
