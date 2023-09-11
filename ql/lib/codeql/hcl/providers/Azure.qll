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
   */
  class AzureProvider extends Provider {
    AzureProvider() { this.getName() = "Azure" }

    Expr getHost() { result = this.getAttribute("host") }

    Expr getConfigPath() { result = this.getAttribute("config_path") }
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
