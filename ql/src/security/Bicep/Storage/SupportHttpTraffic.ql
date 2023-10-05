/**
 * @name Supports non-HTTPS traffic for storage accounts
 * @description Supports non-HTTPS traffic for storage accounts
 * @kind problem
 * @severity warning
 * @security-severity 9.0
 * @precision very-high
 * @id bicep/azure/storage-tls-disabled
 * @tags security
 *       bicep
 *       azure
 *       storage
 */

import bicep

from Storage::StorageAccountsProperties properties
where properties.getSupportsHttpsTrafficOnly() = false
select properties.getProperty("supportsHttpsTrafficOnly"),
  "Supports non-HTTPS traffic for storage accounts."
