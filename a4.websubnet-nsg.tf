##create the subnet
resource "azurerm_subnet" "websubnet" {
  name                 = "${local.resurce_name_prefix}-${var.web_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg1.name 
  virtual_network_name = azurerm_virtual_network.vnet.name 
  address_prefixes     = var.web_subnet_address
}

resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${azurerm_subnet.websubnet.name}-sg"
  location  = azurerm_resource_group.myrg1.location 
  resource_group_name  = azurerm_resource_group.myrg1.name 
}
/*
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
      subnet_id =  azurerm_subnet.websubnet.id
      network_security_group_id = 
}*/