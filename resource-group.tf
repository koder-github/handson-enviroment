provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    features {}
}

data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}

resource "random_string" "random" {
  length           = 6
  number           = true
  upper            = false
  lower            = true
  special          = false
}

resource "azurerm_resource_group" "example" {
    location = var.region
    name     = format("%s-%s", var.resourcegroupname, random_string.random.result)
}