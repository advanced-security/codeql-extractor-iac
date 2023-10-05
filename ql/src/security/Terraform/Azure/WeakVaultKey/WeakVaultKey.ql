/**
 * @name Weak Azure Key Vault Key
 * @description Weak Azure Key Vault Key
 * @kind problem
 * @problem.severity error
 * @security-severity 8.0
 * @precision high
 * @id tf/azure/weak-vault-key
 * @tags security
 *       terraform
 *       azure
 *       vault
 */

import hcl

from Azure::KeyVaultKey key
where
  key.getKeyType() = "RSA" and
  key.getKeySize() < 2048
select key.getAttribute("key_size"), "weak key size"
