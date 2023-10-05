/**
 * @name Dependencies
 * @description List all dependencies.
 * @kind diagnostic
 * @id iac/diagnostics/dependencies
 */

import iac
import codeql.iac.Dependencies

from Dependency dependency
select dependency, "Dependency used " + dependency.getName()
