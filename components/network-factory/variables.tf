variable "project_name" {
  description = "The name of the project (derived from YAML config)."
  type        = string
}

variable "resource_groups" {
  description = "A mapping of environment names to resource group objects."
  type = map(object({
    name     = string
    id       = string
    location = string
  }))
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "westeurope"
}

variable "environments" {
  description = "A list of environments with their subscription types."
  type = list(object({
    name              = string
    subscription_type = string
  }))
}

variable "network_config" {
  description = "The network configuration for different subscription types."
  type = object({
    non_prod = optional(object({
      address_space = list(string)
      subnets = map(object({
        address_prefixes  = list(string)
        service_endpoints = optional(list(string), [])
        delegations = optional(list(object({
          name = string
          service_delegation = object({
            name    = string
            actions = optional(list(string))
          })
        })), [])
        private_endpoint_network_policies = optional(string, "Disabled")
      }))
    }))
    prod = optional(object({
      address_space = list(string)
      subnets = map(object({
        address_prefixes  = list(string)
        service_endpoints = optional(list(string), [])
        delegations = optional(list(object({
          name = string
          service_delegation = object({
            name    = string
            actions = optional(list(string))
          })
        })), [])
        private_endpoint_network_policies = optional(string, "Disabled")
      }))
    }))
  })
  default = {
    non_prod = null
    prod     = null
  }
}

variable "tags" {
  description = "A mapping of tags to apply to all resources."
  type        = map(map(string))
  default     = {}
}
