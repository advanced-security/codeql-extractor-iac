/**
 * @name Azure Managed Storage is Unencrypted
 * @description Azure Storage is Unencrypted
 * @kind problem
 * @problem.severity warning
 * @security-severity 8.0
 * @precision high
 * @id hcl/azure/storage-unencrypted
 * @tags security
 */

import hcl

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
from Resource r, Block encryption_settings, Expr attr
where
  r.getResourceType() = "azurerm_managed_disk" and
  // resource azurerm_managed_disk {
  //   encryption_settings {
  //     enabled = false
  //   }
  // }
  encryption_settings = r.getAttribute("encryption_settings") and
  attr = encryption_settings.getAttribute("enabled") and
  attr.(BooleanLiteral).getBool() = false
select attr, "Azure Storage is Unencrypted for '" + r.getName() + "'"
