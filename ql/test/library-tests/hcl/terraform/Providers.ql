private import codeql.hcl.Terraform
private import codeql.iac.Dependencies

query predicate files(Terraform::TerraformFile f) { any() }

query predicate terraformSettings(Terraform::Terraform t) { any() }

query predicate requiredProvider(Terraform::RequiredProvider p) { any() }
