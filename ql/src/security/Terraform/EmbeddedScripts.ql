/**
 * @name Embedded Scripts
 * @description Embedded Scripts
 * @kind problem
 * @problem.severity note
 * @security-severity 2.0
 * @precision high
 * @id hcl/machine-embedded-scripts
 * @tags security
 *       experimental
 */

import hcl

from Resource resource, HereDoc data
where
  resource.getResourceType() = "aws_instance" and
  data = resource.getAttribute("user_data")
  or
  resource.getResourceType() = "null_resource" and
  data = resource.getAttribute("command")
select data, "Embedded script found"
