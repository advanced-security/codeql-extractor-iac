
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
