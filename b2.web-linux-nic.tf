resource "azurerm_network_interface" "web_linux_nic" {
  name =  "${local.resurce_name_prefix}-web-linuxvm-nic"
  location =  azurerm_resource_group.myrg1.location
  resource_group_name = azurerm_resource_group.myrg1.name
  ip_configuration {
    name = "web-linuxip-1"
    subnet_id = azurerm_subnet.websubnet.id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.web_linux_publicip.id 
  }
}