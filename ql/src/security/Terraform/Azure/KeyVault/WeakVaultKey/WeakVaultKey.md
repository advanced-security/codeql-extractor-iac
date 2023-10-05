# Weak Azure Key Vault Key

When using Azure Key Vault, it is important to ensure that the keys used to encrypt the data are strong enough to withstand brute force attacks.
This policy checks that the key size is at least 2048 bits.

## Examples

Here are the good and bad ways of doing this.

### Bad

The following example will fail the policy check as the key size is too small.

```hcl
resource "azurerm_key_vault_key" "example" {
  name         = "example-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 1024
}
```

### Good

The following example will pass the policy check as the key size is large enough.

```hcl
resource "azurerm_key_vault_key" "example" {
  name         = "example-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048
}
```
