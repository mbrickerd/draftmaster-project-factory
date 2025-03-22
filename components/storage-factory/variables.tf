variable "project_name" {
  description = "The name of the project (derived from YAML config)."
  type        = string
}

variable "environments" {
  description = "A list of environments with their subscription types."
  type = list(object({
    name              = string
    subscription_type = string
  }))
}
