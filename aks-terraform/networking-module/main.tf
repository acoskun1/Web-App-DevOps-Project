# Resource Group
resource "azurerm_resource_group" "aks_rg" {
	name = var.resource_group_name
	location = var.location
}

# VNet
resource "azurerm_virtual_network" "aks_vnet" {
	name = "aks-vnet"
	resource_group_name = azurerm_resource_group.aks_rg.name
	location = azurerm_resource_group.aks_rg.location
	address_space = var.vnet_address_space
}

# Control Plane Subnet
resource "azurerm_subnet" "control_plane_subnet" {
	name = "control-plane-subnet"
	resource_group_name = azurerm_resource_group.aks_rg.name
	virtual_network_name = azurerm_virtual_network.aks_vnet.name
	address_prefixes = ["10.0.1.0/24"]
}

# Worker Node Subnet
resource "azurerm_subnet" "worker_node_subnet" {
	name = "worker-node-subnet"
	resource_group_name = azurerm_resource_group.aks_rg.name
	virtual_network_name = azurerm_virtual_network.aks_vnet.name
	address_prefixes = ["10.0.2.0/24"]
}

# Network Security Group
resource "azurerm_network_security_group" "aks_nsg" {
	name = "aks-nsg"
	location = azurerm_resource_group.aks_rg.location
	resource_group_name = azurerm_resource_group.aks_rg.name
}

resource "azurerm_network_security_rule" "kube_apiserver_rule" {
	name                        = "kube_apiserver_rule"
	priority                    = 1001
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "443"
	source_address_prefix       = var.public_ip_address
	destination_address_prefix  = "*"
	resource_group_name         = azurerm_resource_group.aks_rg.name
	network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

resource "azurerm_network_security_rule" "ssh-rule" {
	name                        = "ssh-rule"
	priority                    = 1002
	direction                   = "Inbound"
	access                      = "Allow"
	protocol                    = "Tcp"
	source_port_range           = "*"
	destination_port_range      = "22"
	source_address_prefix       = var.public_ip_address
	destination_address_prefix  = "*"
	resource_group_name         = azurerm_resource_group.aks_rg.name
	network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

