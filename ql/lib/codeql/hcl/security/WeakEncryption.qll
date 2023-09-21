import hcl

/**
 * Weak Encryption security module for HCL.
 */
module WeakEncryption {
  /**
   * Represents a sink for weak encryption.
   */
  abstract class Sink extends HclAstNode { }

  /**
   * Represents a weak Azure Key Vault Key.
   */
  class AzureVaultKey extends Sink {
    AzureVaultKey() {
      exists(Azure::KeyVaultKey key | key.getKeyType() = "RSA" and key.getKeySize() < 2048 |
        this = key.getAttribute("key_size")
      )
    }
  }
}
