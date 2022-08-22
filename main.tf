module "resource_name" {
  source = "github.com/nexient-llc/tf-module-resource_name.git?ref=0.1.0"

  for_each = var.resource_types

  logical_product_name  = var.logical_product_name
  region                = var.resource_group.location
  class_env             = var.class_env
  cloud_resource_type   = each.value.type
  instance_env          = var.instance_env
  instance_resource     = var.instance_resource
  maximum_length        = each.value.maximum_length
  use_azure_region_abbr = var.use_azure_region_abbr
}

module "resource_group" {
  source = "github.com/nexient-llc/tf-azurerm-module-resource_group.git?ref=0.1.0"

  resource_group      = var.resource_group
  resource_group_name = local.resource_group_name

  tags = local.tags

}

module "app_service_plan" {
  source = "git@github.com:nexient-llc/tf-azurerm-module-service_plan.git?ref=0.1.0"

  resource_group    = local.resource_group
  service_plan_name = local.service_plan_name
}
