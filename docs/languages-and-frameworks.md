# Languages and Frameworks

## Languages

The `codeql-extractor-iac` extractor supports the following languages:

| Name            | Extension(s)                    |
| --------------- | ------------------------------- |
| Terraform / HCL | `.tf`, `.tfvars`, `.hcl`        |
| JSON            | `.json`, `.jsonl`, `.jsonc`     |
| YAML            | `.yaml`, `.yml`                 |
| Container files | `*Dockerfile`, `*Containerfile` |

All of these files will be extracted and stored inside the IaC CodeQL Database.

## Frameworks and Technologies

The `codeql-extractor-iac` is a community extractor and supports a number of frameworks and technologies.
The following table lists the supported frameworks and technologies:

| Name                       | Level Grade | Support Level                   |
| -------------------------- | :---------: | ------------------------------- |
| Terraform (HCL)            |      3      | extractor, library, and queries |
| GitHub Actions             |      3      | extractor, library, and queries |
| ARM Template (YAML / JSON) |      2      | extractor and library           |
| AWS CloudFormation         |      2      | extractor and library           |
| Compose (Docker/Podman)    |      2      | extractor and library           |
| Docker / Container file(s) |      2      | extractor and library           |
| GitHub Actions             |      2      | extractor and library           |
| HelmChart (Kubernetes)     |      2      | extractor and library           |
| OpenAPI / Swagger          |      2      | extractor and library           |
| Azure Bicep                |      0      | currently unsupported           |

_levels grades are based on completeness, higher the grade the better its supported._

### Support Levels

There are 5 levels of support for each framework or technology:

- `0` - Unsupported
  - Not supported at this time but being worked on or planned
- `1` - Extractor Support
  - Code / Data is in the CodeQL Database but no library or queries are provided
  - This results in no alerts and little support for CodeQL writers
- `2` - Extractor and Library Support
  - This includes the extractor and a library to support CodeQL writers
  - This will make writing CodeQL queries easier but still requires CodeQL writers to write their own queries
- `3` - Extractor, Library and Queries Support
  - This includes the extractor, library and CodeQL queries
  - End users can run and generate alerts without having to write their own CodeQL queries
- `4` - Comprehensive Support
  - This includes the extractor, library, CodeQL queries, tests, and documentation
