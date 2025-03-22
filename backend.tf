terraform {
  backend "azurerm" {
    subscription_id      = "7bc4b637-e7b0-4cf5-8105-b46e1c86cb83"
    resource_group_name  = "rg-projectfactory-mgmt"
    storage_account_name = "saprojectfactorymgmt"
    container_name       = "projectfactory-state"
    key                  = "terraform.tfstate"
  }
}