/**
 * @name User not set
 * @description User not set
 * @kind problem
 * @problem.severity note
 * @security-severity 2.0
 * @precision low
 * @id iac/containers/user-not-set
 * @tags security
 */

import iac

from ContainerDefinition container
// where not container.get
select container, "user not set"
