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
import codeql.hcl.security.PublicStorage

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
from AzurePublicStorage public_storage
select public_storage, "Azure Storage is Public"
