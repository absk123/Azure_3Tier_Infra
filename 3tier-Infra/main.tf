terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.113.0"
    }
  }
}

provider "azurerm" {
 features { }
}

resource "azurerm_resource_group" "monolithrg" {
    for_each = var.monolith
  name     = each.value.rg_name
  location = "West Europe"
}

resource "azurerm_virtual_network" "monolithvnet" {
    for_each = var.monolith
  name                = each.value.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.monolithrgc[each.key].location
  resource_group_name = azurerm_resource_group.monolithrg[each.key].name
}

resource "azurerm_subnet" "monolithsbnet" {
    for_each = var.monolith
  name                 = each.value.sbnet_name
  resource_group_name  = azurerm_resource_group.monolithrg[each.key].name
  virtual_network_name = azurerm_virtual_network.monolithvnet[each.key].name
  address_prefixes     = each.value.ip_add
}

resource "azurerm_public_ip" "monolithip" {
    for_each = var.monolith
  name                = each.value.pip_name
  resource_group_name = azurerm_resource_group.monolithrg[each.key].name
  location            = azurerm_resource_group.monolithrg[each.key].location
  allocation_method   = "Static"

}

resource "azurerm_network_interface" "monolithnic" {
    for_each = var.monolith
  name                = each.value.nic_name
  location            = azurerm_resource_group.monolithrg[each.key].location
  resource_group_name = azurerm_resource_group.monolithrg[each.key].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.monolithsbnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.monolithip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "monolithvm" {
    for_each = var.monolith
  name                = each.value.vm_name
  resource_group_name = azurerm_resource_group.monolithrg[each.key].name
  location            = azurerm_resource_group.monolithrg[each.key].location
  size                = each.value.size
  admin_username      = "adminuser"
  admin_password = ""
  disable_password_authentication = true
  network_interface_ids = [    azurerm_network_interface.monolithnic[each.key].id,  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

variable "monolith" { }