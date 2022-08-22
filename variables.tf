#################################################
#Variables associated with resource naming module
##################################################

variable "logical_product_name" {
  type        = string
  description = "(Required) Name of the application for which the resource is created."
  nullable    = false

  validation {
    condition     = length(trimspace(var.logical_product_name)) <= 15 && length(trimspace(var.logical_product_name)) > 0
    error_message = "Length of the logical product name must be between 1 to 15 characters."
  }
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For ex. dev, qa, uat"
  nullable    = false

  validation {
    condition     = length(trimspace(var.class_env)) <= 15 && length(trimspace(var.class_env)) > 0
    error_message = "Length of the environment must be between 1 to 15 characters."
  }

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 1 to 999."
  }
}


variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 1 to 100."
  }
}

variable "use_azure_region_abbr" {
  description = "Whether to use region abbreviation e.g. eastus -> eus"
  type        = bool
  default     = false
}

variable "resource_types" {
  description = "Map of cloud resource types to be used in this module"
  type = map(object({
    type           = string
    maximum_length = number
  }))

  default = {
    "resource_group" = {
      type           = "rg"
      maximum_length = 63
    }
    "cdn_profile" = {
      type           = "cdn"
      maximum_length = 60
    }
    "cdn_endpoint" = {
      type           = "ep"
      maximum_length = 63
    }
    "storage_account" = {
      type           = "sa"
      maximum_length = 24
    }
    "key_vault" = {
      type           = "kv"
      maximum_length = 24
    }
  }
}

#################################################
#Variables associated with resource group module
##################################################
variable "resource_group" {
  description = "resource group primitive options"
  type = object({
    location = string
  })
  validation {
    condition     = length(regexall("\\b \\b", var.resource_group.location)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "custom_tags" {
  description = "custom tags"
  type        = map(string)
  default = {
    "Team" = "My Team"
  }
}