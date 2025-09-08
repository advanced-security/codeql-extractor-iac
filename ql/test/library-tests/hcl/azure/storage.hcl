resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_managed_disk" "example1" {
  name                 = "acctestmd"
  location             = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"
}

resource "azurerm_storage_account" "example2" {
  name                            = "example-account"
  location                        = azurerm_resource_group.example.location
  account_kind                    = var.kind
  account_tier                    = var.tier
  account_replication_type        = var.replication_type
  resource_group_name             = var.resource_group_name
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  min_tls_version                 = var.min_tls_version
}