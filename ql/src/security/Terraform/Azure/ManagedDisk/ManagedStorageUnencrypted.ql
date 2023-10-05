/**
 * @name Azure Managed Storage is Unencrypted
 * @description Azure Storage is Unencrypted
 * @kind problem
 * @problem.severity warning
 * @security-severity 6.0
 * @precision high
 * @id terraform/azure/storage-unencrypted
 * @tags security
 *       terraform
 *       azure
 *       storage
 */

import hcl

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
from Azure::ManagedDisk managed_disk, Azure::ManagedDiskEncryptionSettings settings, Expr sink
where
  not exists(managed_disk.getEncryptionSettings()) and sink = managed_disk
  or
  settings = managed_disk.getEncryptionSettings() and
  settings.getEnabled() = false and
  sink = settings
select sink, "Azure Storage is Unencrypted for '" + managed_disk.getName() + "'"
