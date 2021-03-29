#resource "azurerm_virtual_network" "example" {
#    name                = "azstudynetwork"
#    address_space       = var.networkaddress
#    location            = azurerm_resource_group.example.location
#    resource_group_name = azurerm_resource_group.example.name
#
#    tags = {
#        environment = "Bastion & Terraform Demo"
#        learning = "AzureStudy"
#    }
#}
#
#resource "azurerm_subnet" "internal" {
#    name                 = "internal"
#    resource_group_name  = azurerm_resource_group.example.name
#    virtual_network_name = azurerm_virtual_network.example.name
#    address_prefixes       = var.internalsubnet
#}
#
#resource "azurerm_subnet" "bastion" {
#    name                 = "AzureBastionSubnet "
#    resource_group_name  = azurerm_resource_group.example.name
#    virtual_network_name = azurerm_virtual_network.example.name
#    address_prefixes       = var.bastionsubnet
#}
#
#resource "azurerm_network_security_group" "internal" {
#    name                = "internalnsg"
#    location            = azurerm_resource_group.example.location
#    resource_group_name = azurerm_resource_group.example.name
#    security_rule {
#        name                       = "AzureAll"
#        priority                   = 100
#        direction                  = "Inbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_range     = "*"
#        source_address_prefix      = "AzureCloud"
#        destination_address_prefix = "*"
#    }
#    security_rule {
#        name                       = "AllowRDP"
#        priority                   = 110
#        direction                  = "Inbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_range     = "3389"
#        source_address_prefix      = var.clientip
#        destination_address_prefix = "*"
#    }
#    security_rule {
#        name                       = "AllowClient"
#        priority                   = 120
#        direction                  = "Inbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_range     = "5985"
#        source_address_prefix      = var.clientip
#        destination_address_prefix = "*"
#    }
#    tags = {
#        environment = "Bastion & Terraform Demo"
#    }
#}
#resource "azurerm_public_ip" "example" {
#  name                = "vmpublicip"
#  resource_group_name = azurerm_resource_group.example.name
#  location            = azurerm_resource_group.example.location
#  allocation_method   = "Dynamic"
#
#  tags = {
#      environment = "Bastion & Terraform Demo"
#  }
#}
#
#resource "azurerm_network_security_group" "bastion" {
#    name                = "BastionSecurityGroup"
#    location            = azurerm_resource_group.example.location
#    resource_group_name = azurerm_resource_group.example.name
#    security_rule {
#        name                       = "AllowHttpsInbound"
#        priority                   = 120
#        direction                  = "Inbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_range     = "443"
#        source_address_prefix      = var.clientip
#        destination_address_prefix = "*"
#    }
#    security_rule {
#        name                       = "AllowGatewayManagerInbound"
#        priority                   = 130
#        direction                  = "Inbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_range     = "443"
#        source_address_prefix      = "GatewayManager"
#        destination_address_prefix = "*"
#    }
#
#    security_rule {
#        name                       = "AllowAzureLoadBalancerInbound"
#        priority                   = 140
#        direction                  = "Inbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_range     = "443"
#        source_address_prefix      = "AzureLoadBalancer"
#        destination_address_prefix = "*"
#    }
#
#    security_rule {
#        name                       = "AllowSshRdpOutbound"
#        priority                   = 100
#        direction                  = "Outbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_ranges    = [22,3389]
#        source_address_prefix      = "*"
#        destination_address_prefix = "*"
#    }
#
#    security_rule {
#        name                       = "AllowAzureCloudOutbound"
#        priority                   = 110
#        direction                  = "Outbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_range     = "443"
#        source_address_prefix      = "*"
#        destination_address_prefix = "*"
#    }
#
#    tags = {
#        environment = "Bastion & Terraform Demo"
#    }
#}
#
#resource "azurerm_network_interface" "main" {
#  name                = "jumpserver-nic"
#  resource_group_name = azurerm_resource_group.example.name
#  location            = azurerm_resource_group.example.location
#
#  ip_configuration {
#    name                          = "internal"
#    subnet_id                     = azurerm_subnet.internal.id
#    private_ip_address_allocation = "Dynamic"
#    public_ip_address_id          = azurerm_public_ip.example.id
#  }
#  tags = {
#      environment = "Bastion & Terraform Demo"
#  }
#}
#
#resource "azurerm_public_ip" "bastion" {
#  name                = "bastionip"
#  location            = azurerm_resource_group.example.location
#  resource_group_name = azurerm_resource_group.example.name
#  allocation_method   = "Static"
#  sku                 = "Standard"
#  tags = {
#      environment = "Bastion & Terraform Demo"
#  }
#}
#
#
#output "public_ip" {
#  value = azurerm_public_ip.example
#}
#output "network_interface"{
#  value = azurerm_network_interface.main
#}
#
#resource "azurerm_virtual_machine" "main" {
#  name                            = "jumpserver"
#  resource_group_name             = azurerm_resource_group.example.name
#  location                        = azurerm_resource_group.example.location
#  vm_size                         = var.vmsize
#  network_interface_ids           = [azurerm_network_interface.main.id]
#
#  storage_image_reference  {
#    publisher = var.publisher
#    offer     = var.offer
#    sku       = var.sku
#    version   = var.imageversion
#  }
#
#  storage_os_disk  {
#    name                 = "osdisk"
#    managed_disk_type = "StandardSSD_LRS"
#    caching              = "ReadWrite"
#    create_option        = "FromImage"
#  }
#
#  os_profile {
#    computer_name  = var.computername
#    admin_username = var.vmuser
#    admin_password = var.vmpassword
#    custom_data = file("./files/DSCPowerBI.ps1")
#  }
#
#  os_profile_windows_config {
#      provision_vm_agent        = true
#      enable_automatic_upgrades = true
#      timezone                  = "Tokyo Standard Time"
#  }
#  tags = {
#      environment = "Bastion & Terraform Demo"
#  }
#}
#
#output "azurevm"{
#  value = azurerm_virtual_machine.main
#}
#
#resource "azurerm_virtual_machine_extension" "chocolatey" {
#  count                = length(var.install4chocolatey)
#  name                 = "install4chocolatey"
# 
#  virtual_machine_id   = azurerm_virtual_machine.main.id
#  publisher            = "Microsoft.Compute"
#  type                 = "CustomScriptExtension"
#  type_handler_version = "1.10"
#  depends_on = [azurerm_virtual_machine.main]
#  settings = element(var.install4chocolatey, count.index)
#  tags = {
#     environment = "Bastion & Terraform Demo"
#  }
#}
#
## Connect the security group to the network interface
#resource "azurerm_subnet_network_security_group_association" "bastion" {
#    subnet_id                 = azurerm_subnet.bastion.id
#    network_security_group_id = azurerm_network_security_group.bastion.id
#    # depends_on = [azurerm_bastion_host.example]
#}
#
## Connect the security group to the network interface
#resource "azurerm_subnet_network_security_group_association" "example" {
#    subnet_id                 = azurerm_subnet.internal.id
#    network_security_group_id = azurerm_network_security_group.internal.id
#    #depends_on = [azurerm_virtual_machine_extension.chocolatey]
#}
#
#resource "null_resource" "create_bastion" {
#  provisioner "local-exec" {
#    command = "az network bastion create --name $env:BASTION_NAME --public-ip-address $env:PUBLIC_IP_ADDRESS --resource-group $env:RESOURCE_GROUP_NAME --vnet-name $env:VNET_NAME"
#    interpreter = ["powershell", "-Command"]
#    environment = {
#      BASTION_NAME         = format("%s%s", var.bastion_name, random_string.random.result)
#      RESOURCE_GROUP_NAME  = azurerm_resource_group.example.name
#      VNET_NAME            = azurerm_virtual_network.example.name
#      PUBLIC_IP_ADDRESS    = azurerm_public_ip.bastion.id
#    }
#  }
#  depends_on = [azurerm_public_ip.bastion]
#}
#
#
##resource "azurerm_bastion_host" "example" {
##  name                = format("%s%s", var.bastion_name, random_string.random.result)
##  location            = azurerm_resource_group.example.location
##  resource_group_name = azurerm_resource_group.example.name
##
##  ip_configuration {
##    name                 = "configuration"
##    subnet_id            = azurerm_subnet.bastion.id
##    public_ip_address_id = azurerm_public_ip.bastion.id
##  }
##  #depends_on = [azurerm_subnet_network_security_group_association.bastion]
##  tags = {
##      environment = "Bastion & Terraform Demo"
##  }
##}
#