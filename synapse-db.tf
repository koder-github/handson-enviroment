resource "azurerm_storage_account" "example" {
  name                     = var.storageaccountname
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

resource "azurerm_storage_container" "example" {
  name                  = var.storagecontainer
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "storage" {
  name                  = var.csvstoragecontainer
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}


resource "azurerm_synapse_workspace" "example" {
  name                                 = var.synapseworkspacename
  resource_group_name                  = azurerm_resource_group.example.name
  location                             = azurerm_resource_group.example.location
  storage_data_lake_gen2_filesystem_id = format("https://%s.dfs.core.windows.net/%s", azurerm_storage_account.datalake.name, var.datalakege2name)
  sql_administrator_login              = var.synapseuser
  sql_administrator_login_password     = var.synapsepassword

  aad_admin {
    login     = var.client_userid
    object_id = var.client_objectid
    tenant_id = var.client_tenantid
  }

  tags = {
      environment = "Bastion & Terraform Demo"
      learning = "AzureStudy"
  }
  depends_on = [null_resource.create_datalake_gen2]
}

resource "azurerm_synapse_sql_pool" "example" {
  name                 = var.synapspoolname
  synapse_workspace_id = azurerm_synapse_workspace.example.id
  sku_name             = "DW100c"
  create_mode          = "Default"
  collation            = "Japanese_CS_AS_KS_WS"
  provisioner "local-exec" {
    working_dir = "./"
    command     = "az synapse sql pool pause --name $env:POOL_NAME --workspace-name $env:WORKSPACE_NAME --resource-group $env:RESOURCE_GROUP_NAME"
    interpreter = ["powershell", "-Command"]
    environment = {
      POOL_NAME           = var.synapspoolname
      WORKSPACE_NAME      = azurerm_synapse_workspace.example.name
      RESOURCE_GROUP_NAME = azurerm_resource_group.example.name
    }
  }
}

resource "azurerm_synapse_firewall_rule" "azure" {
  name                 = "AllowAllWindowsAzureIps"
  synapse_workspace_id = azurerm_synapse_workspace.example.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "0.0.0.0"
}

resource "azurerm_synapse_firewall_rule" "client" {
  name                 = "AllowClient"
  synapse_workspace_id = azurerm_synapse_workspace.example.id
  start_ip_address    = var.clientipstart
  end_ip_address      = var.clientipend
}

resource "azurerm_databricks_workspace" "example" {
  name                = var.databricksname
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "trial"
  tags = {
      environment = "Bastion & Terraform Demo"
      learning = "AzureStudy"
  }
}
