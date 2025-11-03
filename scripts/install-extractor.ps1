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
gh release download `
    -R "advanced-security/codeql-extractor-$ExtractorName" `
    -D "$ExtractorLocations" `
    --clobber `
    --pattern 'extractor-*.tar.gz'

Write-Host "Extracting extractor pack..."
tar -zxf "$ExtractorLocations/extractor-$ExtractorName.tar.gz" --directory "$ExtractorLocations"

Write-Host "Installation complete! Extractor installed to: $ExtractorLocations"