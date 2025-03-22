locals {
  common_tags = {
    managed_by_terraform = true
    project_name         = var.project_name
  }

  environment_tags = {
    for env in var.environments : env.name => {
      environment = env.name
    }
  }

  tags = {
    for env in var.environments : env.name => merge(
      local.common_tags,
      local.environment_tags[env.name],
      var.tags
    )
  }

  non_prod_environments = [
    for env in var.environments : env.name
    if env.subscription_type == "non_prod"
  ]

  prod_environments = [
    for env in var.environments : env.name
    if env.subscription_type == "prod"
  ]

  non_prod_subnet_names = {
    for env in local.non_prod_environments : env => keys(lookup(var.subnet_ids.non_prod, env, {}))
  }

  prod_subnet_names = {
    for env in local.prod_environments : env => keys(lookup(var.subnet_ids.prod, env, {}))
  }

  # Process non-production NSG configurations
  non_prod_nsg_configs_temp = flatten([
    for env in local.non_prod_environments : [
      for subnet_name, subnet_config in lookup(var.security_config.network_security_groups, "non_prod", {}) : {
        key         = "${env}-${subnet_name}"
        env         = env
        subnet_name = subnet_name
        config      = subnet_config
        exists      = contains(lookup(local.non_prod_subnet_names, env, []), subnet_name)
      }
    ]
  ])

  non_prod_nsg_configs = {
    for item in local.non_prod_nsg_configs_temp :
    item.key => {
      name                = item.subnet_name
      environment         = item.env
      resource_group_name = var.resource_groups[item.env].name
      location            = var.location
      rules = [
        for rule in item.config.rules : {
          name                       = rule.name
          priority                   = rule.priority
          direction                  = rule.direction
          access                     = rule.access
          protocol                   = rule.protocol
          source_port_range          = "*"
          source_address_prefix      = rule.source_address_prefix
          destination_port_range     = rule.destination_port_range
          destination_address_prefix = rule.destination_address_prefix
          description                = "Security rule managed by Terraform"
        }
      ]
      additional_tags = local.tags[item.env]
    }
    if item.exists
  }

  # Process production NSG configurations
  prod_nsg_configs_temp = flatten([
    for env in local.prod_environments : [
      for subnet_name, subnet_config in lookup(var.security_config.network_security_groups, "prod", {}) : {
        key         = "${env}-${subnet_name}"
        env         = env
        subnet_name = subnet_name
        config      = subnet_config
        exists      = contains(lookup(local.prod_subnet_names, env, []), subnet_name)
      }
    ]
  ])

  prod_nsg_configs = {
    for item in local.prod_nsg_configs_temp :
    item.key => {
      name                = item.subnet_name
      environment         = item.env
      resource_group_name = var.resource_groups[item.env].name
      location            = var.location
      rules = [
        for rule in item.config.rules : {
          name                       = rule.name
          priority                   = rule.priority
          direction                  = rule.direction
          access                     = rule.access
          protocol                   = rule.protocol
          source_port_range          = "*"
          source_address_prefix      = rule.source_address_prefix
          destination_port_range     = rule.destination_port_range
          destination_address_prefix = rule.destination_address_prefix
          description                = "Security rule managed by Terraform"
        }
      ]
      additional_tags = local.tags[item.env]
    }
    if item.exists
  }

  # Create subnet associations for non-production environments
  non_prod_subnet_associations = {
    for nsg_key, nsg_config in local.non_prod_nsg_configs :
    nsg_key => {
      subnet_id = var.subnet_ids.non_prod[nsg_config.environment][nsg_config.name]
      nsg_key   = nsg_key
    }
  }

  # Create subnet associations fxor production environments
  prod_subnet_associations = {
    for nsg_key, nsg_config in local.prod_nsg_configs :
    nsg_key => {
      subnet_id = var.subnet_ids.prod[nsg_config.environment][nsg_config.name]
      nsg_key   = nsg_key
    }
  }
}
