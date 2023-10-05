
// Secure
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: 'secure'
  properties: {
    publicAccess: 'None'
  }
}

// Insecure
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: 'insecure'
  properties: {
    publicAccess: 'Blob'
  }
}
