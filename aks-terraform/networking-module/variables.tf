variable "resource_group_name" {
	type = string
	default = "projectrg"
}

variable "location" {
	type = string
	description = "Azure region where networking resources will be deployed to."
	default = "UK South"
}

variable "vnet_address_space" {
	type = list(string)
	description = "Specifies the address space for the VNet."
	default = ["10.0.0.0/16"]
}

variable "public_ip_address" {
	type = string
	description = "Public IP address for inbound traffic rules."
	default = "172.29.242.168"
}

