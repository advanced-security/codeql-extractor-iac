# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# secure
resource "azurerm_storage_container" "secure" {
  name                  = "secure-storage-container"
  location              = azurerm_resource_group.example.location
  container_access_type = "private"
}

# insecure
resource "azurerm_storage_container" "insecure" {
  name                  = "insecure-storage-container"
  location              = azurerm_resource_group.example.location
  container_access_type = "blob"
  properties = {
    "publicAccess" = "blob"
  }
}

# insecure defaults (v3) 
resource "azurerm_storage_account" "insecure_storage_account" {
  name                     = "insecure-storage-account"
  location                 = azurerm_resource_group.example.location
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  resource_group_name      = azurerm_resource_group.example
  min_tls_version          = "TLS1_2"
}

# Secure (v3)
resource "azurerm_storage_account" "secure_storage_account" {
  name                            = "secure-storage-account"
  location                        = azurerm_resource_group.example.location
  account_kind                    = "BlobStorage"
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  resource_group_name             = azurerm_resource_group.example
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
}

# insecure (v3)
resource "azurerm_storage_account" "insecure_storage_account" {
  name                            = "insecure-storage-account"
  location                        = azurerm_resource_group.example.location
  account_kind                    = "BlobStorage"
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  resource_group_name             = azurerm_resource_group.example
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = true
  min_tls_version                 = "TLS1_2"
}
