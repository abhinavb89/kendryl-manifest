output "web_linuxvm_public_ip" {
  description = "Web Linux VM public Address"
  value = azurerm_public_ip.web_linux_publicip.ip_address
}