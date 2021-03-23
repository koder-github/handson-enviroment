resource "azurerm_storage_account" "datalake" {
  name                     = var.datalake2accountname
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  min_tls_version          = "TLS1_2"
  tags = {
      environment = "Bastion & Terraform Demo"
      learning = "AzureStudy"
  }
}

resource "null_resource" "create_datalake_gen2" {
  provisioner "local-exec" {
    command = "az storage fs create --name $env:DATA_LAKE_GEN2_NAME --account-name $env:STORAGE_ACCOUNT_NAME --account-key $env:ACCOUNT_KEY"
    interpreter = ["powershell", "-Command"]
    environment = {
      STORAGE_ACCOUNT_NAME = azurerm_storage_account.datalake.name
      DATA_LAKE_GEN2_NAME  = var.datalakege2name
      ACCOUNT_KEY          = azurerm_storage_account.datalake.primary_access_key
    }
  }
}
