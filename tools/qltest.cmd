@echo off

type NUL && "%CODEQL_DIST%\codeql.exe" database index-files ^
    --prune=**/*.testproj ^
    --include-extension=.hcl ^
    --include-extension=.tf ^
    --include-extension=.tfvars ^
    --include-extension=.bicep ^
    --size-limit=5m ^
    --language=iac ^
    --working-dir=. ^
    "%CODEQL_EXTRACTOR_IAC_WIP_DATABASE%"

exit /b %ERRORLEVEL%
