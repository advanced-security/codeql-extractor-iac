/**
 * @name Azure Managed Storage is Public
 * @description Azure Managed Storage is Public
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id tf/azure/storage-publicly-accessible
 * @tags security
 *       terraform
 *       azure
 *       storage
 */

import hcl

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
from Azure::StorageContainer managed_disk
where
  managed_disk.getContainerAccessType() = "blob" and
  managed_disk.getProperty("publicAccess").(StringLiteral).getValue() = "blob"
select managed_disk, "Azure Storage is Unencrypted for '" + managed_disk.getName() + "'"
