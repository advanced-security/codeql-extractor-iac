# Workflows

## Basic Usage

To use the CodeQL Extractor, Library, and Queries for Infrastructure as Code, you will need to add the following step to your workflow:

```yaml
- name: Initialize and Analyze IaC
  uses: advanced-security/codeql-extractor-iac@main
```

### Uploading SARIF files to GitHub

```yaml
- name: Upload SARIF file
  uses: github/codeql-action/upload-sarif@v2
  with:
    sarif_file: codeql-iac.sarif
```

## Full Example

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
        id: codeql-iac
        uses: advanced-security/codeql-extractor-iac@main

      - name: Upload SARIF file
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: ${{ steps.changes.outputs.sarif }}
```
