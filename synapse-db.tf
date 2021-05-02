resource "azurerm_storage_account" "datalake" {
  name                     = format("%s%s", var.datalake2accountname, random_string.random.result)
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

resource "azurerm_role_assignment" "user" {
  scope                = azurerm_storage_account.datalake.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.client_objectid
  provisioner "local-exec" {
    working_dir = "./"
    command     = "Start-Sleep -Seconds 10"
    interpreter = var.interpreter
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "example" {
  name               = "dl2sample"
  storage_account_id = azurerm_storage_account.datalake.id
  depends_on = [azurerm_role_assignment.user]
}

resource "azurerm_key_vault_secret" "example" {
  name         = "keyvaultsecret"
  value        = azurerm_storage_account.datalake.primary_access_key
  key_vault_id = azurerm_key_vault.example.id
}

resource "azurerm_synapse_workspace" "example" {
  name                                 = format("%s%s", var.synapseworkspacename, random_string.random.result)
  resource_group_name                  = azurerm_resource_group.example.name
  location                             = azurerm_resource_group.example.location
  storage_data_lake_gen2_filesystem_id = format("https://%s.dfs.core.windows.net/%s", azurerm_storage_account.datalake.name, azurerm_storage_data_lake_gen2_filesystem.example.name)
  sql_administrator_login              = var.synapseuser
  sql_administrator_login_password     = var.synapsepassword

  aad_admin {
    login     = var.client_userid
    object_id = var.client_objectid
    tenant_id = data.azurerm_client_config.current.tenant_id
  }

  tags = {
      environment = "Bastion & Terraform Demo"
      learning = "AzureStudy"
  }
  depends_on = [azurerm_storage_data_lake_gen2_filesystem.example]
}

resource "azurerm_role_assignment" "synapseworkspace" {
  scope                = azurerm_storage_account.datalake.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_synapse_workspace.example.identity[0].principal_id
}

resource "azurerm_role_assignment" "keyvault_synapsews" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_synapse_workspace.example.identity[0].principal_id
}

resource "azurerm_synapse_sql_pool" "example" {
  name                 = var.synapspoolname
  synapse_workspace_id = azurerm_synapse_workspace.example.id
  sku_name             = "DW100c"
  create_mode          = "Default"
  collation            = "Japanese_CS_AS_KS_WS"
  #provisioner "local-exec" {
  #  working_dir = "./"
  #  command     = "az synapse sql pool pause --name $env:POOL_NAME --workspace-name $env:WORKSPACE_NAME --resource-group $env:RESOURCE_GROUP_NAME"
  #  interpreter = var.interpreter
  #  environment = {
  #    POOL_NAME           = var.synapspoolname
  #    WORKSPACE_NAME      = azurerm_synapse_workspace.example.name
  #    RESOURCE_GROUP_NAME = azurerm_resource_group.example.name
  #  }
  #}
}

resource "azurerm_synapse_spark_pool" "example" {
  name                 = var.sparkpoolname
  synapse_workspace_id = azurerm_synapse_workspace.example.id
  node_size_family     = var.sparkpool_node_size_family
  node_size            = var.sparkpool_node_size

  auto_scale {
    max_node_count = var.sparkpool_max_node_count
    min_node_count = var.sparkpool_min_node_count
  }

  auto_pause {
    delay_in_minutes = var.sparkpool_delay_in_minutes
  }
  #library_requirement {
  #  content = "azure"
  #  filename = "requirements.txt"
  #}
  tags = {
      environment = "Bastion & Terraform Demo"
      learning = "AzureStudy"
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

#resource "azurerm_databricks_workspace" "example" {
#  name                = format("%s%s", var.databricksname, random_string.random.result)
#  resource_group_name = azurerm_resource_group.example.name
#  location            = azurerm_resource_group.example.location
#  sku                 = "trial"
#  tags = {
#      environment = "Bastion & Terraform Demo"
#      learning = "AzureStudy"
#  }
#}
