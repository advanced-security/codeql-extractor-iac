private import codeql.Locations
private import codeql.hcl.AST

// Resources are the most important element in the Terraform language.
// Each resource block describes one or more infrastructure objects, such as
// virtual networks, compute instances, or higher-level components such as DNS
// records.
//
// https://developer.hashicorp.com/terraform/language/resources/syntax
class Resource extends Block {
  Resource() { this.hasType("resource") }

  /**
   * Get the name of the resource.
   */
  string getName() { result = this.getLabel(1) }

  /**
   * Get the provider of the resource.
   */
  string getProvider() { result = "Unknown Provider" }

  /**
   * Returns the resource id.
   */
  string getId() { result = this.getName() }

  /**
   * Returns the resource type.
   */
  string getResourceType() { result = this.getLabel(0) }

  /**
   * Checks to see if the resource type matches the given type.
   */
  predicate hasResourceType(string type) { this.getResourceType() = type }

  override string toString() {
    result = "resource " + this.getResourceType() + " " + this.getName()
  }
}

class Provider extends Block {
  Provider() { this.hasType("provider") }

  string getName() { result = this.getLabel(0) }
}
