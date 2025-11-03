param(
    [string]$TestsDir = "ql/test"
)

$ErrorActionPreference = "Stop"

# Check for CodeQL binary
if (Get-Command "codeql" -ErrorAction SilentlyContinue) {
    $CODEQL_BINARY = "codeql"
}
elseif (Get-Command "gh" -ErrorAction SilentlyContinue) {
    try {
        gh codeql version 2>&1 | Out-Null
        $CODEQL_BINARY = "gh codeql"
    }
    catch {
        Write-Host "Installing gh-codeql extension..."
        gh extension install github/gh-codeql
        $CODEQL_BINARY = "gh codeql"
    }
}
else {
    Write-Error "Neither 'codeql' nor 'gh' command found"
    exit 1
}

Write-Host "Installing ql/test pack dependencies..."
if ($CODEQL_BINARY -eq "gh codeql") {
    gh codeql pack install ql/test
}
else {
    codeql pack install ql/test
}

Write-Host "Running tests in $TestsDir"

if ($CODEQL_BINARY -eq "gh codeql") {
    gh codeql test run `
        -j 0 `
        --check-databases --check-unused-labels --check-repeated-labels --check-redefined-labels --check-use-before-definition `
        --search-path ./extractor-pack `
        "$TestsDir"
}
else {
    codeql test run `
        -j 0 `
        --check-databases --check-unused-labels --check-repeated-labels --check-redefined-labels --check-use-before-definition `
        --search-path ./extractor-pack `
        "$TestsDir"
}

if ($LASTEXITCODE -ne 0) {
    Write-Error "Tests failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "All tests passed!"