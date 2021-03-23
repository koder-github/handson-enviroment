resource "null_resource" "key_vault" {
  provisioner "local-exec" {
    working_dir = "./"
    command      = <<-EOT
     az keyvault create --name $env:KEY_VAULT_NAME --default-action Deny --bypass AzureServices --location $env:LOCATION --resource-group $env:RESOURCE_GROUP_NAME --network-acls-ips $env:IPADDRESS --retention-days $env:RETENTION;
     az keyvault set-policy --name $env:KEY_VAULT_NAME --object-id $env:OBJECT_ID --certificate-permissions backup create delete deleteissuers get getissuers import list listissuers managecontacts manageissuers purge recover restore setissuers update --key-permissions create decrypt delete encrypt get import list purge recover restore sign unwrapKey update verify wrapKey --secret-permissions backup delete get list purge recover restore set --storage-permissions backup delete deletesas get getsas list listsas purge recover regeneratekey restore set setsas update;
    EOT
    interpreter = ["powershell", "-Command"]
    environment = {
      LOCATION = azurerm_resource_group.example.location
      KEY_VAULT_NAME = var.key_vaultname
      IPADDRESS = join(" " ,var.key_vault_ipaddress)
      RESOURCE_GROUP_NAME = azurerm_resource_group.example.name
      OBJECT_ID = var.client_objectid
      RETENTION = var.key_vault_retention
    }
  }
}
## work around. soft_delete_enabled is invalid (Failure sending request: StatusCode=400 -- Original Error: Code="BadRequest" Message="A soft deleted vault with the given name does not exist.")
#resource "azurerm_key_vault" "example" {
#  name                        = var.key_vaultname
#  location                    = azurerm_resource_group.example.location
#  resource_group_name         = azurerm_resource_group.example.name
#  enabled_for_disk_encryption = true
#  tenant_id                   = data.azurerm_client_config.current.tenant_id
#  sku_name = "standard"
#  access_policy {
#    tenant_id = data.azurerm_client_config.current.tenant_id
#    object_id = var.client_objectid
#
#    certificate_permissions =[
#      "backup",
#      "create",
#      "delete",
#      "deleteissuers",
#      "get",
#      "getissuers",
#      "import",
#      "list",
#      "listissuers",
#      "managecontacts",
#      "manageissuers",
#      "purge",
#      "recover",
#      "restore",
#      "setissuers",
#      "update"
#    ]
#    key_permissions = [
#      "backup",
#      "create",
#      "decrypt",
#      "delete",
#      "encrypt",
#      "get",
#      "import",
#      "list",
#      "purge",
#      "recover",
#      "restore",
#      "sign",
#      "unwrapKey",
#      "update",
#      "verify",
#      "wrapKey"
#    ]
#    secret_permissions = [
#      "backup",
#      "delete",
#      "get",
#      "list",
#      "purge",
#      "recover",
#      "restore",
#      "set"
#    ]
#    storage_permissions = [
#      "backup",
#      "delete",
#      "deletesas",
#      "get",
#      "getsas",
#      "list",
#      "listsas",
#      "purge",
#      "recover",
#      "regeneratekey",
#      "restore",
#      "set",
#      "setsas",
#      "update"
#    ]
#  }
#  network_acls {
#    default_action = "Deny"
#    bypass         = "AzureServices"
#    ip_rules       = var.key_vault_ipaddress
#  }
#
#  tags = {
#    environment = "Testing"
#  }
#}