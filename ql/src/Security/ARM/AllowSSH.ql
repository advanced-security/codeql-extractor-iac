/**
 * @name Allow SSH access from the Internet
 * @description Allow SSH access from the Internet
 * @kind problem
 * @severity warning
 * @security-severity 4.0
 * @precision very-high
 * @id iac/arm/allow-ssh-from-internet
 * @tags security
 */

import iac

from ArmResource resource, ArmSecurityRule security
where
  security = resource.getProperties().getSecurityRules() and
  security.getProperty("destinationPortRange").toString() = "\"22\""
select security, "test"
