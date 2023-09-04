private import codeql.iac.arm.ARM

query predicate armAstNodes(AzureResourceManager n) { any() }

query predicate armResource(ArmResource n) { any() }

query predicate armResourceProps(ArmResourceProperties n) { any() }
