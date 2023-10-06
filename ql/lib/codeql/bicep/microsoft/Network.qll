private import codeql.Locations
private import codeql.bicep.ast.Expr
private import codeql.bicep.ast.Object
private import codeql.bicep.ast.Resources
private import codeql.bicep.ast.Literal

module Network {
  /**
   * A resource of type Microsoft.Network
   */
  class NetworkResource extends Resource {
    NetworkResource() { this.getResourceType().regexpMatch("^Microsoft.Network/.*") }
  }

  /**
   * A resource of type Microsoft.Network/networkInterfaces
   */
  class NetworkInterfaces extends NetworkResource {
    NetworkInterfaces() {
      this.getResourceType().regexpMatch("^Microsoft.Network/networkInterfaces@.*")
    }

    NetworkInterfaceProperties::Properties getProperties() {
      result = this.getProperty("properties")
    }
  }

  /**
   * A module for all properties of Microsoft.Network/networkInterfaces
   */
  module NetworkInterfaceProperties {
    /**
     * The properties object for the Microsoft.Network/networkInterfaces type
     */
    class Properties extends Object {
      private NetworkInterfaces networkInterfaces;

      Properties() { this = networkInterfaces.getProperty("properties") }

      IpConfiguration getIpConfigurations() {
        result = this.getProperty("ipConfigurations").(Array).getElements()
      }
    }

    /**
     * An IpConfiguration for the Microsoft.Network/networkInterfaces type
     * https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachines?pivots=deployment-language-bicep#virtualmachinenetworkinterfaceipconfigurationproperties
     */
    class IpConfiguration extends Object {
      private Properties properties;

      IpConfiguration() { this = properties.getProperty("ipConfigurations").(Array).getElements() }

      string getName() { result = this.getProperty("name").(StringLiteral).getValue() }
    }
  }
}
