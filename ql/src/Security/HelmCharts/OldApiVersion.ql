/**
 * @name Use of old API version
 * @description Use of old HelmChart API version
 * @kind problem
 * @problem.severity warning
 * @security-severity 4.0
 * @precision very-high
 * @id iac/helmcharts/old-api-version
 * @tags security
 */

import iac

from HelmChart::Document chart
where chart.getApiVersion() = "v1"
select chart, "old API version used"
