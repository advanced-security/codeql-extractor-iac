private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants
private import codeql.hcl.Terraform::Terraform

module AzureStorage {
  private import codeql.hcl.providers.Azure

  /**
   * Azure Managed Disk.
   */
  class ManagedDisk extends Azure::AzureResource {
    ManagedDisk() { this.getResourceType() = "azurerm_managed_disk" }

    override string toString() { result = "ManagedDisk " + this.getName() }

    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    string getStorageAccountType() {
      result = this.getAttribute("storage_account_type").(StringLiteral).getValue()
    }

    /**
     * Get the encryption settings of the managed disk.
     */
    ManagedDiskEncryptionSettings getEncryptionSettings() {
      result = this.getAttribute("encryption_settings")
    }
  }

  /**
   * Azure Managed Disk Encryption Settings.
   */
  class ManagedDiskEncryptionSettings extends Block {
    private ManagedDisk disk;

    ManagedDiskEncryptionSettings() { disk.getAttribute("encryption_settings").(Block) = this }

    override string toString() { result = "ManagedDiskEncryptionSettings" }

    boolean getEnabled() { result = this.getAttribute("enabled").(BooleanLiteral).getBool() }
  }

  class StorageContainer extends Azure::AzureResource {
    StorageContainer() { this.getResourceType() = "azurerm_storage_container" }

    /**
     * Get the name of the storage container.
     */
    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    string getContainerAccessType() {
      result = this.getAttribute("container_access_type").(StringLiteral).getValue()
    }

    /**
     * Get the properties of the managed disk.
     */
    Object getProperties() { result = this.getAttribute("properties") }

    /**
     * Get a property of the managed disk.
     */
    Expr getProperty(string name) { result = this.getProperties().getElementByName(name) }
  }

  /**
   * Azure Storage Account.
   */
  class StorageAccount extends Azure::AzureResource {
    StorageAccount() { this.getResourceType() = "azurerm_storage_account" }

    /**
     * Get the name of the storage account.
     */
    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    /**
     * Get the `allow_blob_public_access` property of the storage account. Only available
     * for `azurerm` v2 and not v3 onwards.
     *
     * https://github.com/hashicorp/terraform-provider-azurerm/blob/main/CHANGELOG-v3.md
     */
    Expr getAllowBlobPublicAccess() {
      this.getProvider().getSemanticVersion().maybeBefore("3.0.0") and
      result = this.getAttribute("allow_blob_public_access")
    }

    /**
     * Get the `allow_blob_public_access` property of the storage account. Only available
     * for `azurerm` v2 and not v3 onwards.
     *
     * https://github.com/hashicorp/terraform-provider-azurerm/blob/main/CHANGELOG-v3.md
     */
    boolean getAllowBlobPublicAccessValue() {
      exists(Expr e | e = this.getAllowBlobPublicAccess() | result = e.(BooleanLiteral).getBool())
      or
      not exists(this.getAllowBlobPublicAccess()) and
      result = true
    }

    /**
     * Get the `public_network_access_enabled` property of the storage account.
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#public_network_access_enabled
     */
    Expr getEnableHttpsTrafficOnly() { result = this.getAttribute("enable_https_traffic_only") }

    /**
     * Get the `public_network_access_enabled` property of the storage account.
     *
     * Defaults to `true`.
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#public_network_access_enabled
     */
    boolean getEnableHttpsTrafficOnlyValue() {
      exists(Expr e | e = this.getEnableHttpsTrafficOnly() | result = e.(BooleanLiteral).getBool())
      or
      not exists(this.getEnableHttpsTrafficOnly()) and
      result = true
    }

    /**
     * Get the `public_network_access_enabled` property of the storage account.
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#public_network_access_enabled
     */
    Expr getPublicNetworkAccess() { result = this.getAttribute("public_network_access_enabled") }

    /**
     * Get the `public_network_access_enabled` property of the storage account.
     *
     * Defaults to `true`.
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#public_network_access_enabled
     */
    boolean getPublicNetworkAccessValue() {
      exists(Expr e | e = this.getPublicNetworkAccess() | result = e.(BooleanLiteral).getBool())
      or
      not exists(this.getPublicNetworkAccess()) and
      result = true
    }

    /**
     * Get the `allow_nested_items_to_be_public` property of the storage account.
     *
     * Defaults to `true`
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#allow_nested_items_to_be_public
     */
    Expr getAllowNestedItemsToBePublic() {
      result = this.getAttribute("allow_nested_items_to_be_public")
    }

    /**
     * Get the `allow_nested_items_to_be_public` property of the storage account.
     *
     * Defaults to `true`
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#allow_nested_items_to_be_public
     */
    boolean getAllowNestedItemsToBePublicValue() {
      exists(Expr e | e = this.getAllowNestedItemsToBePublic() |
        result = e.(BooleanLiteral).getBool()
      )
      or
      not exists(this.getAllowNestedItemsToBePublic()) and
      result = true
    }

    /**
     * Get the `https_traffic_only_enabled` property of the storage account.
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#https_traffic_only_enabled
     */
    Expr getHttpsTrafficOnlyEnabled() { result = this.getAttribute("https_traffic_only_enabled") }

    /**
     * Get the `https_traffic_only_enabled` property of the storage account.
     *
     * Defaults to `true`
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#https_traffic_only_enabled
     */
    boolean getHttpsTrafficOnlyEnabledValue() {
      exists(Expr e | e = this.getHttpsTrafficOnlyEnabled() | result = e.(BooleanLiteral).getBool())
      or
      not exists(this.getHttpsTrafficOnlyEnabled()) and
      result = true
    }

    /**
     * Get the `min_tls_version` property of the storage account.
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#min_tls_version
     */
    Expr getMinTlsVersion() { result = this.getAttribute("min_tls_version") }

    /**
     * Get the `min_tls_version` property of the storage account.
     *
     * Defaults to `TLS1_2`
     *
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html#min_tls_version
     */
    string getMinTlsVersionValue() {
      exists(Expr e | e = this.getMinTlsVersion() | result = e.(StringLiteral).getValue())
      or
      not exists(this.getMinTlsVersion()) and
      result = "TLS1_2"
    }
  }
}