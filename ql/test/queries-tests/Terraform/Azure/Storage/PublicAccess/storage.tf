
# secure
resource "azurerm_storage_container" "secure" {
  name                  = "secure-storage-container"
  container_access_type = "private"
}

# insecure
resource "azurerm_storage_container" "insecure" {
  name                  = "insecure-storage-container"
  container_access_type = "blob"
  properties = {
    "publicAccess" = "blob"
  }
}

# insecure (v3)
resource "azurerm_storage_account" "insecure_storage_account" {
  name                            = "insecure-storage-account"
  location                        = var.location
  account_kind                    = var.kind
  account_tier                    = var.tier
  account_replication_type        = var.replication_type
  resource_group_name             = var.resource_group_name
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = true
  min_tls_version                 = var.min_tls_version
}
