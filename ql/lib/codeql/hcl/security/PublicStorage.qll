import iac

abstract class PublicStorage extends Expr { }

/**
 * Azure Public Storage.
 */
class AzurePublicStorage extends PublicStorage {
  AzurePublicStorage() {
    // Azure Storage Container
    exists(Azure::StorageContainer storage_container |
      storage_container.getContainerAccessType() = "blob" and
      storage_container.getProperty("publicAccess").(StringLiteral).getValue() = "blob"
    )
    or
    // Azure Storage Accounts (v3)
    exists(Azure::StorageAccount storage_acount |
      storage_acount.getPublicNetworkAccess() = true or
      storage_acount.getAllowNestedItemsToBePublic() = true
    )
  }
}
