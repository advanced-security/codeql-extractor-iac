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
    exists(Azure::StorageAccount storage_account |
      (
        // v2
        storage_account.getAllowBlobPublicAccessValue() = true and
        this = storage_account.getAllowBlobPublicAccess()
      )
      or
      (
        // v3
        (
          storage_account.getPublicNetworkAccessValue() = true
          or
          storage_account.getAllowNestedItemsToBePublicValue() = true
        )
        and
        this = storage_account
      )
    )
  }

  override string getProvider() {
    result = "Azure"
  }
}
