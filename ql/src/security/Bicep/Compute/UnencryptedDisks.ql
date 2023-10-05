/**
 * @name Unencrypted compute disks
 * @description Unencrypted compute disks
 * @kind problem
 * @severity warning
 * @security-severity 4.0
 * @precision very-high
 * @id bicep/azure/unencrypted-disks
 * @tags security
 *       bicep
 *       azure
 */

import bicep

from Compute::DisksProperties properties
where properties.getEncryptionEnabled() = false
select properties.getProperty("encryptionSettingsCollection"), "Unencrypted compute disks."
