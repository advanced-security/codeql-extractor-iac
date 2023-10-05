# Azure Blob Container Public Access

When using a Bicep template to create a storage account, you can specify the public access level for the blob container. The default value is set to `None` which means that the container is private and can only be accessed by the storage account owner. The other options are `Blob` and `Container` which allow anonymous read access to the blob or container respectively.

## Examples

### Bad Example

```bicep
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: 'insecure'
  properties: {
    publicAccess: 'Blob'
  }
}
```

### Good Example

```bicep
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: 'secure'
  properties: {
    publicAccess: 'None'
  }
}
```
