variable "resource_group_name" {
	type = string
	description = "Cloud resource group name in which networking resources will be created."
}

variable "location" {
	type = string
	description = "Azure region where networking resources will be deployed to."
}

variable "vnet_address_space" {
	type = list(string)
	description = "Specifies the address space for the VNet in CIDR notation."
	default = ["10.0.0.0/16"]
}

variable "public_ip_address" {
	type = string
	description = "Public IP address for inbound traffic rules."
}

