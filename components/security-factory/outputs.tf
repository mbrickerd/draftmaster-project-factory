output "non_prod_nsg_ids" {
  description = "A mapping of non-production network security group IDs by environment and subnet name."
  value = {
    for env in local.non_prod_environments : env => {
      for nsg_key, nsg in module.non_prod_nsgs :
      nsg.name => nsg.id
      if startswith(nsg_key, "${env}-")
    }
    if length([for nsg_key, _ in module.non_prod_nsgs : nsg_key if startswith(nsg_key, "${env}-")]) > 0
  }
}

output "prod_nsg_ids" {
  description = "A mapping of production network security group IDs by environment and subnet name."
  value = {
    for env in local.prod_environments : env => {
      for nsg_key, nsg in module.prod_nsgs :
      nsg.name => nsg.id
      if startswith(nsg_key, "${env}-")
    }
    if length([for nsg_key, _ in module.prod_nsgs : nsg_key if startswith(nsg_key, "${env}-")]) > 0
  }
}

output "non_prod_subnet_nsg_associations" {
  description = "A mapping of non-production subnet to NSG associations."
  value = {
    for key, association in azurerm_subnet_network_security_group_association.non_prod : key => {
      subnet_id = association.subnet_id
      nsg_id    = association.network_security_group_id
    }
  }
}

output "prod_subnet_nsg_associations" {
  description = "A mapping of production subnet to NSG associations."
  value = {
    for key, association in azurerm_subnet_network_security_group_association.prod : key => {
      subnet_id = association.subnet_id
      nsg_id    = association.network_security_group_id
    }
  }
}
