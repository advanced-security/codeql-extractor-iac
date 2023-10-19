private import codeql.Locations
private import codeql.bicep.Ast
private import codeql.bicep.ast.internal.Resources
private import codeql.bicep.microsoft.Network

/**
 * A resource of type Microsoft.Compute/virtualMachines
 */
module Compute {
  class ComputeResource extends Resource {
    ComputeResource() { this.getResourceType().regexpMatch("^Microsoft.Compute/.*") }
  }

  /**
   * A resource of type Microsoft.Compute/virtualMachines
   * https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachines
   */
  class VirtualMachines extends ComputeResource {
    VirtualMachines() {
      this.getResourceType().regexpMatch("^Microsoft.Compute/virtualMachines@.*")
    }

    string toString() { result = "VirtualMachines Resource" }

    VirtualMachinesProperties::Properties getProperties() {
      result = this.getProperty("properties")
    }

    /**
     * The the hardware network interfaces of the virtual machine
     */
    Network::NetworkInterfaces getNetworkInterfaces() {
      result = this.getProperties().getNetworkProfile().getNetworkInterfaces()
    }
  }

  /**
   * The properties module for Microsoft.Compute/virtualMachines
   */
  module VirtualMachinesProperties {
    /**
     * The properties object for the Microsoft.Compute/virtualMachines type
     */
    class Properties extends Object {
      private VirtualMachines virtualMachines;

      Properties() { this = virtualMachines.getProperty("properties") }

      VirtualMachines getVirtualMachine() { result = virtualMachines }

      HardwareProfile getHardwareProfile() { result = this.getProperty("hardwareProfile") }

      NetworkProfile getNetworkProfile() { result = this.getProperty("networkProfile") }

      OsProfile getOsProfile() { result = this.getProperty("osProfile") }
    }

    /**
     * The hardwareProfile property object for the Microsoft.Compute/virtualMachines type
     */
    class HardwareProfile extends Object {
      private Properties properties;

      HardwareProfile() { this = properties.getProperty("hardwareProfile") }

      string toString() { result = "HardwareProfile" }

      Expr getVmSize() { result = this.getProperty("vmSize") }
    }

    /**
     * A NetworkProfile for the Microsoft.Compute/virtualMachines type
     */
    class NetworkProfile extends Object {
      private Properties properties;

      NetworkProfile() { this = properties.getProperty("networkProfile") }

      string toString() { result = "NetworkProfile" }

      Network::NetworkInterfaces getNetworkInterfaces() {
        result = resolveResource(this.getNetworkInterfacesObject())
      }

      private Object getNetworkInterfacesObject() {
        result = this.getProperty("networkInterfaces").(Array).getElements()
      }
    }

    /**
     */
    class StorageProfile extends Object {
      private Properties properties;

      StorageProfile() { this = properties.getProperty("storageProfile") }

      ImageReference getImageReference() { result = this.getProperty("imageReference") }
    }

    /**
     * A ImageReference for the Microsoft.Compute/virtualMachines type
     * https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachines?pivots=deployment-language-bicep#imagereference
     */
    class ImageReference extends Object {
      private StorageProfile storageProfile;

      ImageReference() { this = storageProfile.getProperty("imageReference") }

      Expr getPublisher() { result = this.getProperty("publisher") }

      Expr getOffer() { result = this.getProperty("offer") }

      Expr getSku() { result = this.getProperty("sku") }

      Expr getVersion() { result = this.getProperty("version") }
    }

    /**
     * The OsProfile object for the Microsoft.Compute/virtualMachines type
     */
    class OsProfile extends Object {
      private Properties properties;

      OsProfile() { this = properties.getProperty("osProfile") }

      Expr getComputerName() { result = this.getProperty("computerName") }

      Expr getAdminUsername() { result = this.getProperty("adminUsername") }

      Expr getAdminPassword() { result = this.getProperty("adminPassword") }
    }
  }
}
