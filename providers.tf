provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = local.config.subscriptions.non_prod
}

provider "azurerm" {
  alias = "non_prod"

  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = local.config.subscriptions.non_prod
}

provider "azurerm" {
  alias = "prod"

  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }

  subscription_id = local.config.subscriptions.prod
}

provider "azurerm" {
  alias = "mgmt"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }

  subscription_id = "7bc4b637-e7b0-4cf5-8105-b46e1c86cb83"
}

