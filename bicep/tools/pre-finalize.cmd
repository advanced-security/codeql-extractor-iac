@echo off

type NUL && "%CODEQL_DIST%\codeql" database index-files ^
    --include=*.yml ^
    --include=*.yaml ^
    --include=*.json ^
    --include=*.jsonc ^
    --include=*.jsonl ^
    --size-limit=5m ^
    --language yaml ^
    -- ^
    "%CODEQL_EXTRACTOR_QL_WIP_DATABASE%"

exit /b %ERRORLEVEL%