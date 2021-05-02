resource "azurerm_key_vault" "example" {
  name                        = format("%s%s", var.key_vaultname, random_string.random.result)
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.client_objectid

    certificate_permissions =[
      "backup",
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "purge",
      "recover",
      "restore",
      "setissuers",
      "update"
    ]
    key_permissions = [
      "backup",
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey"
    ]
    secret_permissions = [
      "backup",
      "delete",
      "get",
      "list",
      "purge",
      "recover",
      "restore",
      "set"
    ]
    storage_permissions = [
      "backup",
      "delete",
      "deletesas",
      "get",
      "getsas",
      "list",
      "listsas",
      "purge",
      "recover",
      "regeneratekey",
      "restore",
      "set",
      "setsas",
      "update"
    ]
  }
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = var.key_vault_ipaddress
  }

  tags = {
      environment = "Bastion & Terraform Demo"
      learning = "AzureStudy"
  }
}