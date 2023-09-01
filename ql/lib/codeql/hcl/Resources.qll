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

  string getName() { result = this.getLabel(1) }

  string getResourceType() { result = this.getLabel(0) }

  override string toString() {
    result = "resource " + this.getResourceType() + " " + this.getName()
  }
}
