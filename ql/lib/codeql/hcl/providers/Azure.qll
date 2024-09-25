private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

module Azure {
  /**
   * Azure resources.
   *
   * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
   */
  class AzureResource extends Resource, Block {
    AzureResource() { this.getResourceType().regexpMatch("^azurerm.*") }

    override string getProvider() { result = "Azurerm" }
  }

  /**
   * Azure provider.
   *
   * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
   */
  class AzureProvider extends Provider {
    AzureProvider() { this.getName() = "azurerm" }

    Expr getHost() { result = this.getAttribute("host") }

    Expr getConfigPath() { result = this.getAttribute("config_path") }

    Expr getFeatures() { result = this.getAttribute("features") }
  }

  /**
   * Azure Resource Group.
   */
  class ResourceGroup extends AzureResource {
    ResourceGroup() { this.getResourceType() = "azurerm_resource_group" }

    override string toString() { result = "ResourceGroup " + this.getName() }

    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    Expr getResourceLocation() { result = this.getAttribute("location") }
  }

  /**
   * Azure Managed Disk.
   */
  class ManagedDisk extends AzureResource {
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

  class StorageContainer extends AzureResource {
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

  class StorageAccount extends AzureResource {
    StorageAccount() { this.getResourceType() = "azurerm_storage_account" }

    /**
     * Get the name of the storage account.
     */
    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    boolean getEnableHttpsTrafficOnly() {
      result = this.getAttribute("enable_https_traffic_only").(BooleanLiteral).getBool()
    }

    boolean getPublicNetworkAccess() {
      result = this.getAttribute("public_network_access_enabled").(BooleanLiteral).getBool()
    }

    boolean getAllowNestedItemsToBePublic() {
      result = this.getAttribute("allow_nested_items_to_be_public").(BooleanLiteral).getBool()
    }
  }

  /**
   * Azure Databases
   */
  class Database extends AzureResource {
    Database() {
      this.getResourceType()
          .regexpMatch("^azurerm_(sql|mariadb|mssql|postgresql)_(server|database)")
    }

    override string toString() { result = "Database " + this.getName() }

    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    string getVersion() { result = this.getAttribute("version").(StringLiteral).getValue() }

    boolean getSslEnforcementEnabled() {
      result = this.getAttribute("ssl_enforcement_enabled").(BooleanLiteral).getBool()
    }

    boolean getInfrastructureEncryptionEnabled() {
      result = this.getAttribute("infrastructure_encryption_enabled").(BooleanLiteral).getBool()
    }

    boolean getGeoRedundantBackupEnabled() {
      result = this.getAttribute("geo_redundant_backup_enabled").(BooleanLiteral).getBool()
    }

    Expr getAdministratorPassword() { result = this.getAttribute("administrator_login_password") }
  }

  /**
   * Azure Key Vault.
   */
  class KeyVault extends AzureResource {
    KeyVault() { this.getResourceType() = "azurerm_key_vault" }

    override string toString() { result = "KeyVault " + this.getName() }
  }

  /**
   * Azure Key Vault Key.
   */
  class KeyVaultKey extends AzureResource {
    KeyVaultKey() { this.getResourceType() = "azurerm_key_vault_key" }

    override string toString() { result = "KeyVaultKey " + this.getName() }

    string getKeyType() { result = this.getAttribute("key_type").(StringLiteral).getValue() }

    int getKeySize() { result = this.getAttribute("key_size").(NumericLiteral).getInt() }
    // string getKeyOpts() { result = this.getAttribute("key_opts") }
  }

  /**
   * Azure Key Vault Secret.
   */
  class KeyVaultSecret extends AzureResource {
    KeyVaultSecret() { this.getResourceType() = "azurerm_key_vault_secret" }
  }

  /**
   * Azure Security Center Contact.
   */
  class SecurityCenterContact extends AzureResource {
    SecurityCenterContact() { this.getResourceType() = "azurerm_security_center_contact" }

    string getEmail() { result = this.getAttribute("email").(StringLiteral).getValue() }

    boolean getAlertNotifications() {
      result = this.getAttribute("alert_notifications").(BooleanLiteral).getBool()
    }

    boolean getAlertsToAdmins() {
      result = this.getAttribute("alerts_to_admins").(BooleanLiteral).getBool()
    }
  }
}
