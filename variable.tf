variable "region" {
  type = string
  default = "japaneast"
}

variable "resourcegroupname" {
  type = string
  default = "<Resource Name>"
}

variable "networkaddress" {
  type    = list(string)
  default = ["192.168.0.0/24"]
}

variable "clientip" {
  type    = string
  default = "<ipaddress>/32"
}

variable "clientipstart" {
  type    = string
  default = "<ipaddress>"
}

variable "clientipend" {
  type    = string
  default = "<ipaddress>"
}

variable "internalsubnet" {
  type    = list(string)
  default = ["192.168.0.0/27"]
}

variable "bastionsubnet" {
  type    = list(string)
  default = ["192.168.0.32/27"]
}

variable "vmsize" {
  type    = string
  default = "Standard_D2d_v4"
}

variable "computername" {
  type    = string
  default = "clienthost"  
}
variable "vmuser" {
  type    = string
  default = "adminuser"
}

variable "vmpassword" {
  type    = string
  default = "<password>"
}

variable "publisher" {
  type    = string
  default = "MicrosoftWindowsServer"
}

variable "offer" {
  type    = string
  default = "windowsserver-gen2preview"
}

variable "sku" {
  type    = string
  default = "2019-datacenter-gen2"
}

variable "imageversion" {
  type    = string
  default = "latest"
}

variable "sqlservername" {
  type    = string
  default = "<prefix>sqlserver"
}

variable "sqluser" {
  type    = string
  default = "adminuser"
}

variable "sqlpassword" {
  type    = string
  default = "<password>"
}

variable "storageaccountname" {
  type    = string
  default = "<prefix>synapse"
}

variable "storagecontainer" {
  type    = string
  default = "synapse"
}

variable "csvstoragecontainer" {
  type    = string
  default = "sample"
}

variable "databricksname" {
  type    = string
  default = "<prefix>databricks"
}

variable "key_vaultname" {
  type    = string
  default = "<prefix>keyvault"
}

variable "key_vault_retention" {
  type    = string
  default = "7"
}

variable "client_objectid" {
  type    = string
  default = "<object_id>"
}

variable "key_vault_ipaddress"{
  type    = list(string)
  default = ["<ipaddress>/32"]
}

variable "install4chocolatey" {
  type    = list(string)
  default = ["{\"commandToExecute\": \"powershell.exe -Command \\\"Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); if($?) { powershell.exe -Command \\\"choco install vscode microsoftazurestorageexplorer -dvfy\\\" } powershell.exe -Command \\\"Rename-Item %SYSTEMDRIVE%\\\\AzureData\\\\CustomData.bin %SYSTEMDRIVE%\\\\AzureData\\\\powerbiinstall.ps1\\\"; powershell.exe -sta -ExecutionPolicy Unrestricted -file %SYSTEMDRIVE%\\\\AzureData\\\\powerbiinstall.ps1;\\\"\"}"]
}

variable "package4chocolatey" {
  type    = list(string)
  default = ["{\"commandToExecute\": \"powershell.exe \\\"choco install vscode powerbi microsoftazurestorageexplorer azure-data-studio\\\"\"}"]
}

