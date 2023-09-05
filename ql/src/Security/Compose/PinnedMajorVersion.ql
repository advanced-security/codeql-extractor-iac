/**
 * @name Using old version of Compose
 * @description Compose files with pinned version
 * @kind problem
 * @problem.severity note
 * @security-severity 1.0
 * @precision very-high
 * @id iac/containers/latest-images
 * @tags maintainability
 */

import iac

from Compose::Document compose
where compose.getApiVersion() = ["2", "3"]
select compose, "pinned version of Compose spec"
