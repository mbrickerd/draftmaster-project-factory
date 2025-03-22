variable "project_key" {
  description = "The key of the project YAML configuration file."
  type        = string
}

variable "project_name" {
  description = "The name of the project (derived from YAML config)."
  type        = string
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

variable "tags" {
  description = "A mapping of tags to apply to all resources."
  type        = map(map(string))
  default     = {}
}
