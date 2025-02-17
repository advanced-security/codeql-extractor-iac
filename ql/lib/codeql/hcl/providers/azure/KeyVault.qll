private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants
private import codeql.hcl.Terraform::Terraform


module AzureKeyVault {
  private import codeql.hcl.providers.Azure

  /**
   * Azure Key Vault.
   */
  class KeyVault extends Azure::AzureResource {
    KeyVault() { this.getResourceType() = "azurerm_key_vault" }

    override string toString() { result = "KeyVault " + this.getName() }
  }

  /**
   * Azure Key Vault Key.
   */
  class KeyVaultKey extends Azure::AzureResource {
    KeyVaultKey() { this.getResourceType() = "azurerm_key_vault_key" }

    override string toString() { result = "KeyVaultKey " + this.getName() }

    string getKeyType() { result = this.getAttribute("key_type").(StringLiteral).getValue() }

    int getKeySize() { result = this.getAttribute("key_size").(NumericLiteral).getInt() }
    // string getKeyOpts() { result = this.getAttribute("key_opts") }
  }

  /**
   * Azure Key Vault Secret.
   */
  class KeyVaultSecret extends Azure::AzureResource {
    KeyVaultSecret() { this.getResourceType() = "azurerm_key_vault_secret" }
  }
}