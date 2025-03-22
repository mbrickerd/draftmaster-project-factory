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

variable "subnet_ids" {
  description = "A mapping of subnet IDs by subscription type and environment."
  type = object({
    non_prod = map(map(string))
    prod     = map(map(string))
  })
}

variable "security_config" {
  description = "The security configuration including network security groups."
  type = object({
    network_security_groups = optional(object({
      non_prod = optional(map(object({
        rules = list(object({
          name                         = string
          priority                     = number
          direction                    = string
          access                       = string
          protocol                     = string
          source_port_range            = optional(string)
          source_port_ranges           = optional(list(string))
          source_address_prefix        = optional(string)
          source_address_prefixes      = optional(list(string))
          destination_port_range       = optional(string)
          destination_port_ranges      = optional(list(string))
          destination_address_prefix   = optional(string)
          destination_address_prefixes = optional(list(string))
          description                  = optional(string, "")
        }))
      })), {})
      prod = optional(map(object({
        rules = list(object({
          name                         = string
          priority                     = number
          direction                    = string
          access                       = string
          protocol                     = string
          source_port_range            = optional(string)
          source_port_ranges           = optional(list(string))
          source_address_prefix        = optional(string)
          source_address_prefixes      = optional(list(string))
          destination_port_range       = optional(string)
          destination_port_ranges      = optional(list(string))
          destination_address_prefix   = optional(string)
          destination_address_prefixes = optional(list(string))
          description                  = optional(string, "")
        }))
      })), {})
    }), {})
  })
  default = {
    network_security_groups = {}
  }
}

variable "tags" {
  description = "A mapping of tags to apply to all resources."
  type        = map(map(string))
  default     = {}
}
