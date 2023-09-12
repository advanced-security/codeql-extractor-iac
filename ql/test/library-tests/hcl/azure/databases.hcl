resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_sql_server" "example" {
  name                = "myexamplesqlserver"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  version             = "12.0"
}

resource "azurerm_mariadb_server" "example" {
  name                = "mariadb-svr"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  version             = "10.2"
}

resource "azurerm_mssql_server" "example" {
  name                = "example-sqlserver"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  version             = "12.0"
}
