resource "azurerm_resource_group" "myrg1" {
  name = "myrg-1"
  location = "East Us"
}

resource "azurerm_resource_group" "myrg2" {
  name = "myrg-3"
  location = "West Us"
  provider = azurerm.provider2-westus
  ###provider.alias name
}