import iac

abstract class PublicStorage extends Expr {
  abstract string getProvider();
}

/**
 * Azure Public Storage.
 */
class AzurePublicStorage extends PublicStorage {
  AzurePublicStorage() {
    // Azure Storage Container
    exists(Azure::StorageContainer storage_container |
      storage_container.getContainerAccessType() = "blob" and
      storage_container.getProperty("publicAccess").(StringLiteral).getValue() = "blob"
      and
      this = storage_container
    )
    or
    // Azure Storage Accounts
    exists(Azure::StorageAccount storage_acount |
      (
        // v2
        storage_acount.getAllowBlobPublicAccessValue() = true and
        this = storage_acount.getAllowBlobPublicAccess()
      )
      or
      (
        // v3
        (
          storage_acount.getPublicNetworkAccessValue() = true
          or
          storage_acount.getAllowNestedItemsToBePublicValue() = true
        )
        and
        this = storage_acount
      )
    )
  }

  override string getProvider() {
    result = "Azure"
  }
}
