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

    string toString() { result = "NetworkInterfaces Resource" }

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

  /**
   * A resource of type Microsoft.Network/virtualNetworks
   */
  class VirtualNetworks extends NetworkResource {
    VirtualNetworks() {
      this.getResourceType().regexpMatch("^Microsoft.Network/virtualNetworks@.*")
    }

    string toString() { result = "VirtualNetworks Resource" }

    /**
     * Get the properties object for the Microsoft.Network/virtualNetworks type
     */
    VirtualNetworkProperties::Properties getProperties() { result = this.getProperty("properties") }
  }

  /**
   * A resource of type Microsoft.Network/virtualNetworks/subnets
   */
  class VirtualNetworkSubnets extends Resource {
    VirtualNetworkSubnets() {
      this.getResourceType().regexpMatch("^Microsoft.Network/virtualNetworks/subnets@.*")
    }
  }

  module VirtualNetworkProperties {
    /**
     * The properties object for the Microsoft.Network/virtualNetworks/subnets type
     */
    class Properties extends Object {
      private VirtualNetworkSubnets virtualNetworkSubnets;

      Properties() { this = virtualNetworkSubnets.getProperty("properties") }

      AddressSpace getAddressSpace() { result = this.getProperty("addressSpace") }

      boolean getEnableDdosProtection() {
        result = this.getProperty("enableDdosProtection").(BooleanLiteral).getBool()
      }

      boolean getEnableVmProtection() {
        result = this.getProperty("enableVmProtection").(BooleanLiteral).getBool()
      }
    }

    /**
     * An AddressSpace for the Microsoft.Network/virtualNetworks type
     */
    class AddressSpace extends Object {
      private Properties properties;

      AddressSpace() { this = properties.getProperty("addressSpace") }

      string getAddressPrefixes() {
        result =
          this.getProperty("addressPrefixes").(Array).getElements().(StringLiteral).getValue()
      }
    }
  }
}
