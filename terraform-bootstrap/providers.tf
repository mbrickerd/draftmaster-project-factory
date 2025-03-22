provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  subscription_id                 = "7bc4b637-e7b0-4cf5-8105-b46e1c86cb83"
  resource_provider_registrations = "none"
}
