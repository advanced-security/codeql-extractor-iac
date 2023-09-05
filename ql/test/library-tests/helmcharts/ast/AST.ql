private import iac

query predicate helmchart(HelmChart::Document n) { any() }

query predicate helmchartValues(HelmChartValues::Document n) { any() }

query predicate helmchartAssignedValues(HelmChart::Document doc) { exists(doc.getValues()) }

query predicate helmchartDeps(HelmChart::Dependency n) { any() }
