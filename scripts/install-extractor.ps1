param(
    [string]$ExtractorName = "iac",
    [string]$ExtractorLocations = "$env:USERPROFILE\.codeql\extractors"
)

$ErrorActionPreference = "Stop"

Write-Host "Creating extractor directory..."
if (!(Test-Path $ExtractorLocations)) {
    New-Item -ItemType Directory -Path $ExtractorLocations -Force | Out-Null
}

Write-Host "Checking latest release..."
gh release list -L 1 -R "advanced-security/codeql-extractor-$ExtractorName"

Write-Host "Downloading extractor pack..."
$ghArgs = @(
    'release', 'download',
    '-R', "advanced-security/codeql-extractor-$ExtractorName",
    '-D', "$ExtractorLocations",
    '--clobber',
    '--pattern', 'extractor-*.tar.gz'
)
& gh @ghArgs
if ($LASTEXITCODE -ne 0) {
    Write-Error "gh release download failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "Extracting extractor pack..."
tar -zxf "$ExtractorLocations/extractor-$ExtractorName.tar.gz" --directory "$ExtractorLocations"
if ($LASTEXITCODE -ne 0) {
    Write-Error "tar extraction failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "Installation complete! Extractor installed to: $ExtractorLocations"