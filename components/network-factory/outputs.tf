output "non_prod_vnet_ids" {
  description = "A mapping of non-production virtual network IDs by environment."
  value = {
    for env, vnet in module.non_prod_vnets : env => vnet.id
  }
}

output "prod_vnet_ids" {
  description = "A mapping of production virtual network IDs by environment."
  value = {
    for env, vnet in module.prod_vnets : env => vnet.id
  }
}

output "non_prod_vnet_names" {
  description = "A mapping of non-production virtual network names by environment."
  value       = local.non_prod_vnet_names
}

output "prod_vnet_names" {
  description = "A mapping of production virtual network names by environment."
  value       = local.prod_vnet_names
}

output "non_prod_subnet_ids" {
  description = "A mapping of non-production subnet IDs by environment and subnet name."
  value = {
    for env in local.non_prod_environments : env => {
      for subnet in local.non_prod_subnet_configs :
      subnet.subnet_name => module.non_prod_subnets["${subnet.subnet_name}-${env}"].id
      if subnet.key == "${subnet.subnet_name}-${env}" &&
      contains(keys(module.non_prod_subnets), "${subnet.subnet_name}-${env}")
    }
    if length([for subnet in local.non_prod_subnet_configs : subnet if endswith(subnet.key, "-${env}")]) > 0
  }
}

output "prod_subnet_ids" {
  description = "A mapping of production subnet IDs by environment and subnet name."
  value = {
    for env in local.prod_environments : env => {
      for subnet in local.prod_subnet_configs :
      subnet.subnet_name => module.prod_subnets["${subnet.subnet_name}-${env}"].id
      if subnet.key == "${subnet.subnet_name}-${env}" &&
      contains(keys(module.prod_subnets), "${subnet.subnet_name}-${env}")
    }
    if length([for subnet in local.prod_subnet_configs : subnet if endswith(subnet.key, "-${env}")]) > 0
  }
}

output "non_prod_subnet_names" {
  description = "A mapping of non-production subnet names by environment."
  value = {
    for env in local.non_prod_environments : env => [
      for subnet in local.non_prod_subnet_configs :
      subnet.subnet_name
      if subnet.vnet_key == env
    ]
  }
}

output "prod_subnet_names" {
  description = "A mapping of production subnet names by environment."
  value = {
    for env in local.prod_environments : env => [
      for subnet in local.prod_subnet_configs :
      subnet.subnet_name
      if subnet.vnet_key == env
    ]
  }
}
