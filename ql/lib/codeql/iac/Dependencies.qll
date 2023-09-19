private import codeql.Locations
private import codeql.hcl.Terraform

/**
 * Dependency for all Infrastructure as Code languages.
 */
class Dependency extends Location {
  string name;
  string version;

  Dependency() {
    // Terraform Provider
    exists(Terraform::Terraform tf, Terraform::RequiredProvider rp | rp = tf.getRequiredProvider() |
      this = rp.getLocation() and
      name = rp.getSource() and
      version = rp.getVersion()
    )
  }

  override string toString() { result = this.getName() + "@" + this.getVersion() }

  /**
   * Gets the name of the dependency.
   */
  string getName() { result = name }

  /**
   * Gets the version of the dependency.
   */
  string getVersion() { result = version.replaceAll("=", "") }

  SemanticVersion getSemanticVersion() { result = this.getVersion() }
}

class SemanticVersion extends string {
  private Dependency dep;

  SemanticVersion() { this = dep.getVersion() }
}
