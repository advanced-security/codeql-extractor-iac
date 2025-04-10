/**
 * @name Successfully extracted files
 * @description Lists all files in the source code directory that were extracted
 *   without encountering an error in the file.
 * @kind diagnostic
 * @id bicep/diagnostics/successfully-extracted-files
 * @tags successfully-extracted-files
 */

import bicep
import codeql.bicep.Diagnostics


from File f
where
  not exists(ExtractionError e | e.getLocation().getFile() = f) and
  exists(f.getRelativePath())
select f, ""
