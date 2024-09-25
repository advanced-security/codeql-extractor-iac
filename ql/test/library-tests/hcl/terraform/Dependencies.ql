import hcl

query predicate dependencies(Dependency d) { any() }

query predicate semver(Dependency d, SemanticVersion v) { d.getSemanticVersion() = v }
