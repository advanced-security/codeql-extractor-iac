/**
 * Classes and predicates for analyzing Azure (Microsoft Azure) provider resources and configurations in HCL.
 * This module provides specific support for Azure resources, data sources, and provider configurations
 * commonly used in Terraform and other HCL-based infrastructure-as-code tools.
 */

private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

/**
 * Azure provider module containing classes for analyzing Azure-specific HCL configurations.
 *
 * This module provides specialized classes for Azure resources like virtual machines, storage accounts,
 * Azure Kubernetes Service clusters, and other Azure services commonly defined in Terraform configurations.
 */
module Azure {
  /**
   * An Azure resource in HCL configuration.
   *
   * Azure resources represent infrastructure components that are managed by Microsoft Azure,
   * such as virtual machines, storage accounts, databases, networking components, etc.
   *
   * Example Azure resources:
   * ```
   * resource "azurerm_virtual_machine" "main" {
   *   name                = "my-vm"
   *   location            = azurerm_resource_group.main.location
   *   resource_group_name = azurerm_resource_group.main.name
   * }
   *
   * resource "azurerm_storage_account" "example" {
   *   name                     = "mystorageaccount"
   *   resource_group_name      = azurerm_resource_group.main.name
   *   location                 = azurerm_resource_group.main.location
   *   account_tier             = "Standard"
   *   account_replication_type = "LRS"
   * }
   * ```
   */
  class AzureResource extends Resource, Block {
    AzureResource() { this.getResourceType().regexpMatch("^azurerm.*") }
  }

  /**
   * An Azure provider configuration block.
   *
   * The Azure provider block configures authentication and regional settings
   * for Azure resource management in Terraform.
   *
   * Example Azure provider:
   * ```
   * provider "azurerm" {
   *   features {}
   *
   *   subscription_id = var.azure_subscription_id
   *   client_id       = var.azure_client_id
   *   client_secret   = var.azure_client_secret
   *   tenant_id       = var.azure_tenant_id
   * }
   * ```
   */
  class AzureProvider extends Provider {
    AzureProvider() { this.getName() = "azurerm" }

    /** Gets the Azure host configuration expression. */
    Expr getHost() { result = this.getAttribute("host") }

    /** Gets the configuration path expression. */
    Expr getConfigPath() { result = this.getAttribute("config_path") }

    /** Gets the features configuration block. */
    Expr getFeatures() { result = this.getAttribute("features") }
  }

  /**
   * An Azure Resource Group resource.
   *
   * Resource groups are containers that hold related resources for an Azure solution.
   * They provide a way to organize and manage resources as a group.
   *
   * Example Azure resource group:
   * ```
   * resource "azurerm_resource_group" "main" {
   *   name     = "my-resource-group"
   *   location = "West Europe"
   *
   *   tags = {
   *     Environment = "production"
   *   }
   * }
   * ```
   */
  class ResourceGroup extends AzureResource {
    ResourceGroup() { this.getResourceType() = "azurerm_resource_group" }

    override string toString() { result = "ResourceGroup " + this.getName() }

    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    /** Gets the Azure region location for this resource group. */
    Expr getResourceLocation() { result = this.getAttribute("location") }
  }

  /**
   * An Azure Managed Disk resource.
   *
   * Managed disks provide persistent storage for Azure virtual machines with
   * built-in high availability and scalability features.
   *
   * Example Azure managed disk:
   * ```
   * resource "azurerm_managed_disk" "example" {
   *   name                 = "example-disk"
   *   location             = azurerm_resource_group.main.location
   *   resource_group_name  = azurerm_resource_group.main.name
   *   storage_account_type = "Premium_LRS"
   *   create_option        = "Empty"
   *   disk_size_gb         = 100
   * }
   * ```
   */
  class ManagedDisk extends AzureResource {
    ManagedDisk() { this.getResourceType() = "azurerm_managed_disk" }

    override string toString() { result = "ManagedDisk " + this.getName() }

    override string getName() { result = this.getAttribute("name").(StringLiteral).getValue() }

    /** Gets the storage account type (e.g., "Premium_LRS", "Standard_LRS"). */
    string getStorageAccountType() {
      result = this.getAttribute("storage_account_type").(StringLiteral).getValue()
    }

    /**
     * Gets the encryption settings configuration for this managed disk.
     */
    ManagedDiskEncryptionSettings getEncryptionSettings() {
      result = this.getAttribute("encryption_settings")
    }
  }

  /**
   * Azure Managed Disk encryption settings configuration.
   *
   * This configuration block defines encryption settings for managed disks,
   * including customer-managed keys and disk encryption sets.
   *
   * Example encryption settings:
   * ```
   * resource "azurerm_managed_disk" "example" {
   *   name = "example-disk"
   *
   *   encryption_settings {
   *     enabled = true
   *
   *     disk_encryption_key {
   *       secret_url      = azurerm_key_vault_secret.example.id
   *       source_vault_id = azurerm_key_vault.example.id
   *     }
   *   }
   * }
   * ```
   */
  class ManagedDiskEncryptionSettings extends Block {
    private ManagedDisk disk;

    ManagedDiskEncryptionSettings() { disk.getAttribute("encryption_settings").(Block) = this }

    override string toString() { result = "ManagedDiskEncryptionSettings" }

    boolean getEnabled() { result = this.getAttribute("enabled").(BooleanLiteral).getBool() }
  }

  class StorageContainer extends AzureResource {
    StorageContainer() { this.getResourceType() = "azurerm_storage_container" }

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
