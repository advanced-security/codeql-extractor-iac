private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants
private import codeql.hcl.Terraform::Terraform


module AzureDatabases {
  private import codeql.hcl.providers.Azure

  /**
   * Azure Databases
   */
  class Database extends Azure::AzureResource {
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
   * Azure Cosmos DB
   */
  class CosmosDbAccount extends Azure::AzureResource {
    CosmosDbAccount() { this.getResourceType() = "azurerm_cosmosdb_account" }

    /**
     * Get the `minimal_tls_version` attribute of the Cosmos DB account.
     * 
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account#minimal_tls_version
     */
    Expr getMinimalTlsVersion() {
      result = this.getAttribute("minimal_tls_version")
    }

    /**
     * Get the value of the `minimal_tls_version` attribute of the Cosmos DB account.
     * 
     * Defaults to `TLS1_2`.
     * 
     * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account#minimal_tls_version
     */
    string getMinimalTlsVersionValue() {
      exists(Expr e | e = this.getMinimalTlsVersion() | result = e.(StringLiteral).getValue())
      or
      not exists(this.getMinimalTlsVersion())
      and
      result = "TLS1_2"
    }
  }
}