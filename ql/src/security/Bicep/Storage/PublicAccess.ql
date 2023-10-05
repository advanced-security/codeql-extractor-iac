/**
 * @name Azure Blob Container Public Access
 * @description Azure Blob Container Public Access
 * @kind problem
 * @problem.severity error
 * @security-severity 10.0
 * @precision high
 * @id bicep/azure/storage-publicly-accessible
 * @tags security
 *       bicep
 *       azure
 *       storage
 */

import bicep

from Storage::BlobServiceContainers container
where container.getPublicAccess() = ["Blob", "Container"]
select container, "Public Blob Container resource."
