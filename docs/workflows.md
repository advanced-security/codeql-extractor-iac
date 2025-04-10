# Workflows

## Basic Usage

To use the CodeQL Extractor, Library, and Queries for Infrastructure as Code, you will need to add the following step to your workflow:

```yaml
- name: Initialize and Analyze IaC
  uses: advanced-security/codeql-extractor-iac@v0.4.1
```

### Uploading SARIF files to GitHub

The CodeQL Extractor will produce a SARIF file but will not upload it for you.
This has to be done manually or using the `github/codeql-action/upload-sarif` action like so:

```yaml
- name: Upload SARIF file
  uses: github/codeql-action/upload-sarif@v3
  with:
    sarif_file: codeql-iac.sarif
```

### Full Action Example

_`.github/workflows/codeql-iac.yml`_ :

```yaml
name: "CodeQL IaC"

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  workflow_dispatch:

jobs:
  analyze:
    name: Analyze
    runs-on: "ubuntu-latest"
    permissions:
      actions: read
      contents: read
      security-events: write

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Initialize and Analyze IaC
        id: codeql_iac
        uses: advanced-security/codeql-extractor-iac@v0.4.1

      - name: Upload SARIF file
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: ${{ steps.codeql_iac.outputs.sarif }}
```

## CodeQL CLI

The CodeQL CLI can be used to analyze IaC files using the CodeQL Extractor, Library, and Queries for Infrastructure as Code. You will need to follow these steps to use the CodeQL CLI:

1. Download the latest CodeQL CLI
   - Recommended to use the [GitHub CLI Extension github/gh-codeql](https://github.com/github/gh-codeql) for CodeQL
2. Download and install the extractor version you want to use
   - The extractor should be placed in the codeql dist folder
   - Running `codeql version --format=json` will show the location of the codeql dist folder
3. Check the extractor is installed correctly by running:
   - `codeql resolve languages` and checking if `iac` is listed
4. Install the IaC queries pack by running:
   - `codeql pack install advanced-security/iac-queries`
5. Run the CodeQL database commands to create and analyze the IaC files
   - `codeql database create <database-name> --language=iac --source-root=<path-to-iac-files>`
   - `codeql database analyze <database-name> --format=sarif-latest --output=<output-file-name> advanced-security/iac-queries`

### CLI Example

#### Install extractor

```bash
# CodeQL Dist directory
CODEQL_DIST=$(codeql version --format=json | jq -r '.unpackedLocation')

# Download
gh release download \
    -R "advanced-security/codeql-extractor-iac" \
    -D "$CODEQL_DIST" \
    --clobber \
    --pattern 'extractor-*.tar.gz'

tar -zxf "$CODEQL_DIST/extractor-iac.tar.gz" --directory "$CODEQL_DIST"
```

#### Create and analyze database

```bash
CODEQL_DATABASE="codeql-iac"
# Create database
codeql database create \
  --language=iac \
  --overwrite \
  "$CODEQL_DATABASE"

# Analyze database and output SARIF file
codeql database analyze \
  --format="sarif-latest" \
  --output="./codeql-iac.sarif" \
  "$CODEQL_DATABASE" \
  "advanced-security/iac-queries"
```
