/**
 * Dependencies module for Infrastructure as Code languages.
 */
private import codeql.Locations
private import codeql.hcl.Terraform

/**
 * Dependency for all Infrastructure as Code languages.
 */
abstract class Dependency extends Location {
  /**
   * Gets the name of the dependency.
   */
  abstract string getName();
  /**
   * Gets the version of the dependency (in a format that is human-readable).
   */
  abstract string getVersion();
  /**
   * Gets the raw version of the dependency (in a format that is machine-readable).
   */
  abstract string getRawVersion();
  /**
   * Gets the semantic version of the dependency.
   */
  abstract SemanticVersion getSemanticVersion();
}


/**
 * Dependency for Terraform.
 */
class TerraformDependency extends Dependency {
  string name;
  string version;

  TerraformDependency() {
    // Terraform Provider
    exists(Terraform::Terraform tf, Terraform::RequiredProvider rp | rp = tf.getRequiredProvider() |
      this = rp.getLocation() and
      name = rp.getSource() and
      version = rp.getVersion()
    )
  }

  override string toString() { result = this.getName() + "@" + this.getVersion() }

  override string getName() { result = name }


  override string getVersion() { result = this.getSemanticVersion().getPretty() }


  override string getRawVersion() { result = version }

  override SemanticVersion getSemanticVersion() { result = version  }
}

class SemanticVersion extends string {
  Dependency dep;
  string normalized;
  string pretty;

  SemanticVersion() {
    this = dep.getRawVersion() and
    normalized = normalizeSemver(this) and 
    pretty = prettySemver(this)
  }

  /**
   * Holds if this version may be before `last`.
   */
  bindingset[last]
  predicate maybeBefore(string last) { normalized < normalizeSemver(last) }

  /**
   * Holds if this version may be after `first`.
   */
  bindingset[first]
  predicate maybeAfter(string first) { normalizeSemver(first) < normalized }

  /**
   * Holds if this version may be between `first` (inclusive) and `last` (exclusive).
   */
  bindingset[first, last]
  predicate maybeBetween(string first, string last) {
    normalizeSemver(first) <= normalized and
    normalized < normalizeSemver(last)
  }

  /**
   * Holds if this version is equivalent to `other`.
   */
  bindingset[other]
  predicate is(string other) { normalized = normalizeSemver(other) }

  string getPretty() { result = pretty }
}

bindingset[str]
private string leftPad(string str) { result = ("000" + str).suffix(str.length()) }

/**
 * Normalizes a SemVer string such that the lexicographical ordering
 * of two normalized strings is consistent with the SemVer ordering.
 *
 * Pre-release information and build metadata is not yet supported.
 */
bindingset[orig]
private string normalizeSemver(string orig) {
  exists(string pattern, string major, string minor, string patch |
    pattern = "(=|~>|^)(\\d+)\\.(\\d+)\\.(\\d+)" and
    major = orig.regexpCapture(pattern, 2) and
    minor = orig.regexpCapture(pattern, 3) and
    patch = orig.regexpCapture(pattern, 4)
  |
    result = leftPad(major) + "." + leftPad(minor) + "." + leftPad(patch)
  )
}

bindingset[orig]
private string prettySemver(string orig) {
  exists(string pattern, string major, string minor, string patch |
    pattern = "(=|~>|^)(\\d+)\\.(\\d+)\\.(\\d+)" and
    major = orig.regexpCapture(pattern, 2) and
    minor = orig.regexpCapture(pattern, 3) and
    patch = orig.regexpCapture(pattern, 4)
  |
    result = major + "." + minor + "." + patch
  )
}