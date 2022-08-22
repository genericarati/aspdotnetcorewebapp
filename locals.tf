locals {
  resource_group_name = module.resource_name["resource_group"].recommended_per_length_restriction
  service_plan_name   = module.resource_name["app_service_plan"].recommended_per_length_restriction

  resource_group = {
    location = var.resource_group.location
    name     = module.resource_group.resource_group.name
  }

  default_tags = {
    provisioner = "Terraform"
  }

  tags = merge(var.custom_tags, local.default_tags)
}