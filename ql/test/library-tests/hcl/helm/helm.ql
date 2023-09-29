import hcl

query predicate helm(TerraformHelmChart::HelmResource r) { any() }

query predicate provider(TerraformHelmChart::HelmProvider p) { any() }

query predicate release(TerraformHelmChart::Release r) { any() }

query predicate releaseSets(TerraformHelmChart::Release r, TerraformHelmChart::ReleaseSet s) {
  r.getSets() = s
}
