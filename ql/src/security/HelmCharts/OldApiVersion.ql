/**
 * @name Use of old API version
 * @description Use of old HelmChart API version
 * @kind problem
 * @problem.severity warning
 * @security-severity 4.0
 * @precision very-high
 * @id helmcharts/kubernetes/old-api-version
 * @tags security
 *       experimental
 */

import iac

from HelmChart::Document chart
where chart.getApiVersion() = "v1"
select chart, "old API version used"
