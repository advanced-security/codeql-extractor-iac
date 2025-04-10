@echo off

type NUL && "%CODEQL_EXTRACTOR_BICEP_ROOT%\tools\%CODEQL_PLATFORM%\extractor" autobuild

exit /b %ERRORLEVEL%