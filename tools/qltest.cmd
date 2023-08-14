@echo off

type NUL && "%CODEQL_DIST%\codeql.exe" database index-files ^
    --prune=**/*.testproj ^
    --include-extension=.hcl ^
    --include-extension=.yml ^
    --size-limit=5m ^
    --language=hcl ^
    --working-dir=. ^
    "%CODEQL_EXTRACTOR_IAC_WIP_DATABASE%"

exit /b %ERRORLEVEL%
