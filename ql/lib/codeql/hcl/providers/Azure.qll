private import codeql.hcl.AST
private import codeql.hcl.Resources
private import codeql.hcl.Constants
private import codeql.hcl.Terraform::Terraform

module Azure {
  /**
   * Azure resources.
   *
   * https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
   */
  class AzureResource extends Resource, Block {
    AzureResource() { this.getResourceType().regexpMatch("^azurerm.*") }

    override RequiredProvider getProvider() { result = getProviderByName("azurerm") }
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

  // Re-export the Azure resources
  import codeql.hcl.providers.azure.Storage::AzureStorage
  import codeql.hcl.providers.azure.Databases::AzureDatabases
  import codeql.hcl.providers.azure.KeyVault::AzureKeyVault
  import codeql.hcl.providers.azure.SecurityCenter::AzureSecurityCenter
}