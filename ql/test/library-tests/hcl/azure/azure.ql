import hcl

query predicate azure(Azure::AzureResource r) { any() }

query predicate azureManagedDisk(Azure::ManagedDisk md) { any() }

query predicate azureDatabases(Azure::Database db) { any() }
