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

from Azure::KeyVaultKey key
where
  key.getKeyType() = "RSA" and
  key.getKeySize() < 2048
select key.getAttribute("key_size"), "weak key size"
