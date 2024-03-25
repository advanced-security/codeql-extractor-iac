private import iac

query predicate helmchart(HelmChart::Document n) { any() }

query predicate helmchartValues(HelmChartValues::Document n) { any() }

query predicate helmchartAssignedValues(HelmChart::Document doc) { exists(doc.getValues()) }

query predicate helmchartSpec(HelmChart::Spec n) { any() }

query predicate helmchartContainers(HelmChart::Container n) { any() }

query predicate helmchartContainerSecurityContext(HelmChart::SecurityContext n) { any() }

query predicate helmchartDeps(HelmChart::Dependency n) { any() }

query predicate helmchartData(HelmChart::HelmData n) { any() }
