/**
 * @name Hardcoded Passwords
 * @description Hardcoded Passwords
 * @kind problem
 * @problem.severity error
 * @security-severity 8.0
 * @precision high
 * @id tf/all/hardcoded-passwords
 * @tags security
 */

import hcl

from PasswordSinks sinks
select sinks, "Hardcoded Password"
