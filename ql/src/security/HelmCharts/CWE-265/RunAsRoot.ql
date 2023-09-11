/**
 * @name Pod running as rool in Helm Chart
 * @description Pod running as rool in Helm Chart
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id iac/helmcharts/pod-run-as-root
 * @tags security
 *       helmchart
 *       external/cwe/cwe-265
 */

import iac

from HelmChart::SecurityContext security_context
where
  security_context.getRunAsUser() = 0
  or
  security_context.getRunAsGroup() = 0
select security_context, "root user set"
