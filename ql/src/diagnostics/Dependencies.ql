/**
 * @name Dependencies
 * @description List all dependencies.
 * @kind diagnostic
 * @id iac/diagnostics/dependencies
 */

import iac

from Dependency dependency
select dependency, "Dependency used " + dependency.getName()
