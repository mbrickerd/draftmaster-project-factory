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

  non_prod_resource_groups = {
    for env in local.non_prod_environments : env => lookup(
      var.resource_groups,
      env,
      null
    )
  }

  prod_resource_groups = {
    for env in local.prod_environments : env => lookup(
      var.resource_groups,
      env,
      null
    )
  }

  non_prod_vnet_names = {
    for env in local.non_prod_environments : env => var.project_name
  }

  prod_vnet_names = {
    for env in local.prod_environments : env => var.project_name
  }

  empty_network_config = {
    address_space = []
    subnets       = {}
  }

  non_prod_subnet_configs = flatten([
    for env in local.non_prod_environments : [
      for subnet_name, subnet in lookup(
        var.network_config.non_prod != null ? var.network_config.non_prod : local.empty_network_config,
        "subnets",
        {}
        ) : {
        key               = "${subnet_name}-${env}"
        vnet_key          = env
        subnet_name       = subnet_name
        address_prefixes  = subnet.address_prefixes
        service_endpoints = lookup(subnet, "service_endpoints", [])
        delegations       = lookup(subnet, "delegations", [])
      }
      if contains(keys(module.non_prod_vnets), env)
    ]
  ])

  prod_subnet_configs = flatten([
    for env in local.prod_environments : [
      for subnet_name, subnet in lookup(
        var.network_config.prod != null ? var.network_config.prod : local.empty_network_config,
        "subnets",
        {}
        ) : {
        key               = "${subnet_name}-${env}"
        vnet_key          = env
        subnet_name       = subnet_name
        address_prefixes  = subnet.address_prefixes
        service_endpoints = lookup(subnet, "service_endpoints", [])
        delegations       = lookup(subnet, "delegations", [])
      }
      if contains(keys(module.prod_vnets), env)
    ]
  ])
}
