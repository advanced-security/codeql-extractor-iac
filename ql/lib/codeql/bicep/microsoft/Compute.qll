private import codeql.Locations
private import codeql.bicep.ast.Expr
private import codeql.bicep.ast.Object
private import codeql.bicep.ast.Resources
private import codeql.bicep.ast.Literal

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

    VirtualMachinesProperties::Properties getProperties() {
      result = this.getProperty("properties")
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

      Object getOsProfile() { result = this.getProperty("osProfile") }
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
