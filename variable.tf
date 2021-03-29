variable "region" {
  type = string
  default = "japaneast"
}

variable "resourcegroupname" {
  type = string
  default = "azstudy"
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

variable "synapseworkspacename" {
  type    = string
  default = "synapsews"
}

#name can contain only letters, numbers or underscore, The value must be between 1 and 15 characters long
variable "synapspoolname" {
  type    = string
  default = "hanbankanri"
}

variable "synapseuser" {
  type    = string
  default = "adminuser"
}

variable "synapsepassword" {
  type    = string
  default = "<password>"
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
  default = "databricks"
}


variable "datalake2accountname" {
  type    = string
  default = "dl2"
}

variable "datalakege2name" {
  type    = string
  default = "dl2"
}

variable "key_vaultname" {
  type    = string
  default = "keyvault"
}

variable "key_vault_retention" {
  type    = string
  default = "7"
}

variable "client_userid" {
  type    = string
  default = "<client_user_id>"
}


variable "key_vault_ipaddress"{
  type    = list(string)
  default = ["<ipaddress>/32"]
}

variable "install4chocolatey" {
  type    = list(string)
  default = ["{\"commandToExecute\": \"powershell.exe -Command \\\"Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); if($?) { powershell.exe -Command \\\"choco install vscode microsoftazurestorageexplorer -fy\\\" } powershell.exe -Command \\\"Rename-Item %SYSTEMDRIVE%\\\\AzureData\\\\CustomData.bin %SYSTEMDRIVE%\\\\AzureData\\\\powerbiinstall.ps1\\\"; powershell.exe -sta -ExecutionPolicy Unrestricted -file %SYSTEMDRIVE%\\\\AzureData\\\\powerbiinstall.ps1;\\\"\"}"]
}

variable "bastion_name" {
  type    = string
  default = "bastion"
}
