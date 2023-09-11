private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants

module Azure {
  /**
   * Azure resources.
   */
  class AzureResource extends Resource, Block {
    AzureResource() { this.getResourceType().regexpMatch("^azurerm.*") }
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
