@echo off

"%CODEQL_DIST%\codeql.exe" database index-files ^
    --prune=**/*.testproj ^
    --include-extension=.hcl ^
    --include-extension=.tf ^
    --include-extension=.tfvars ^
    --include-extension=.bicep ^
    --size-limit=5m ^
    --language=iac ^
    --working-dir=. ^
    "%CODEQL_EXTRACTOR_IAC_WIP_DATABASE%"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

"%CODEQL_DIST%\codeql.exe" database index-files ^
    --prune=**/*.testproj ^
    --include-extension=.yml ^
    --include-extension=.yaml ^
    --include-extension=.json ^
    --size-limit=5m ^
    --language=yaml ^
    --working-dir=. ^
    "%CODEQL_EXTRACTOR_IAC_WIP_DATABASE%"

exit /b %ERRORLEVEL%
