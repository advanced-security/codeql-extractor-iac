/**
 * @name Hardcoded Passwords
 * @description Hardcoded Passwords
 * @kind problem
 * @problem.severity error
 * @security-severity 8.0
 * @precision high
 * @id hcl/hardcoded-passwords
 * @tags security
 */

import hcl

from ConstantExpr e
where
  // Azure
  exists(Resource r |
    e = r.getAttribute("administrator_login_password")
    or
    // Username
    e = r.getAttribute("administrator_login")
  )
  or
  // AWS
  exists(Block b |
    b.hasType("provider") and
    b.getLabel(0) = "aws" and
    (
      e = b.getAttribute("access_key")
      or
      e = b.getAttribute("secret_key")
    )
  )
  or
  exists(Resource r | r.getResourceType() = "aws_db_instance" |
    e = r.getAttribute("username") or e = r.getAttribute("password")
  )
//
select e, "Hardcoded Password"
