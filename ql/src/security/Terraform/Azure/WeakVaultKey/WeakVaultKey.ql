/**
 * @name Weak Azure Key Vault Key
 * @description Weak Azure Key Vault Key
 * @kind problem
 * @problem.severity error
 * @security-severity 7.0
 * @precision high
 * @id hcl/azure/weak-vault-key
 * @tags security
 */

import hcl
import codeql.hcl.security.WeakEncryption

from WeakEncryption::AzureVaultKey key
select key, "weak key size"
