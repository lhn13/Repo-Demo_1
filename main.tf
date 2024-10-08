variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
}

variable "location" {
    description = "The location of the resource group"
    type        = string
    default     = "East US"
}

variable "virtual_network_name" {
    description = "The name of the virtual network"
    type        = string
}

variable "address_space" {
    description = "The address space of the virtual network"
    type        = list(string)
}

variable "subnet_prefixes" {
    description = "The address prefixes for the subnets"
    type        = list(string)
}
variable "subnet_names" {
    description = "The names of the subnets"
    type        = list(string)
    default     = ["subnet1", "subnet2", "subnet3"]
}

resource "azurerm_virtual_network" "main" {
    name                = var.virtual_network_name
    address_space       = var.address_space
    location            = var.location
    resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnets" {
    count                = length(var.subnet_names)
    name                 = var.subnet_names[count.index]
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = [element(var.subnet_prefixes, count.index)]
}