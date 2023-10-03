locals {
webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
sudo apt-get update -y
sudo apt install apache2
sudo systemctl enable apache2
sudo systemctl start apache2  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html
sudo echo "Welcome to test - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to test - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to test - WebVM App1 - App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
CUSTOM_DATA
}

resource "azurerm_linux_virtual_machine" "web_linux_vm" {
  name =  "${local.resurce_name_prefix}-web-linuxvm"
  location =  azurerm_resource_group.myrg1.location
  resource_group_name = azurerm_resource_group.myrg1.name
  size = "Standard_DS1_v2"
  admin_username = "azureuser"
  admin_password = var.adminpw
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.web_linux_nic.id]
  /*admin_ssh_key {
    username = "azureuser"
    ##path.module is the root directory it is like callign your current directory
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }*/
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  ###to execute the boot strap script
  custom_data = base64encode(local.webvm_custom_data)
  #if you boot strap data is in inside a file in shell format
  #custom_data = filebase64("${path.module}/app/app.sh")
}