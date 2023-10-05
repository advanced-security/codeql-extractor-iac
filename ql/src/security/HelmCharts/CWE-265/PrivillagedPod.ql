/**
 * @name Privillaged Pod enabled in Helm Chart
 * @description Privillaged Pod enabled in Helm Chart
 * @kind problem
 * @problem.severity warning
 * @security-severity 9.0
 * @precision high
 * @id hc/kubernetes/privileged-pod
 * @tags security
 *       helmcharts
 *       external/cwe/cwe-265
 */

import iac

from HelmChart::Spec spec, HelmChart::SecurityContext security_context, YamlMapping sink
where
  spec.getPrivileged() = true and sink = spec
  or
  security_context.getPrivileged() = true and sink = security_context
select sink.lookup("privileged"), "privileged enabled"
