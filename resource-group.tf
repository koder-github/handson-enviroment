provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
    location = var.region
    name     = var.resourcegroupname
}