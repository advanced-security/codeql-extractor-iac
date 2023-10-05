/**
 * @name Unencrypted compute disks
 * @description Unencrypted compute disks
 * @kind problem
 * @severity warning
 * @security-severity 7.0
 * @precision very-high
 * @id bicep/azure/compute-unencrypted
 * @tags security
 *       bicep
 *       azure
 *       compute
 */

import bicep

from Compute::DisksProperties properties
where properties.getEncryptionEnabled() = false
select properties.getProperty("encryptionSettingsCollection"), "Unencrypted compute disks."
