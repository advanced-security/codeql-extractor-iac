/**
 * @name User not set
 * @description User not set
 * @kind problem
 * @severity info
 * @security-severity 2.0
 * @precision low
 * @id iac/containers/user-not-set
 * @tags security
 *       experimental
 */

import iac

from ContainerDefinition container
// where not container.get
select container, "user not set"
