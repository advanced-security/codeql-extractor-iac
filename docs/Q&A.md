# Questions and Answers

## Q: What is `codeql-extractor-iac`?

The `codeql-extractor-iac` is a community extractor for the [CodeQL] static analysis engine.
It is a community extractor that is designed to extract and analyze Infrastructure as Code (IaC) files.

## Q: What is the `codeql-extractor-iac` used for?

The `codeql-extractor-iac` is used to extract and analyze IaC files.
It is designed to find security vulnerabilities, misconfigurations, and best practices for different IaC frameworks and technologies.

## Q: What support does GitHub / CodeQL provide to `codeql-extractor-iac`?

The CodeQL IaC extractor is a community extractor and is not supported by GitHub or CodeQL teams.
All issues should be reported to the `codeql-extractor-iac` [Issues] or [Discussions] and is not officially supported as part of the [GitHub Advanced Security] offering..

## Q: What languages does the `codeql-extractor-iac` support?

The `codeql-extractor-iac` supports the following languages:

| Name            | Extension(s)                    |
| --------------- | ------------------------------- |
| Terraform / HCL | `.tf`, `.tfvars`, `.hcl`        |
| JSON            | `.json`, `.jsonl`, `.jsonc`     |
| YAML            | `.yaml`, `.yml`                 |
| Container files | `*Dockerfile`, `*Containerfile` |

## Q: What frameworks and technologies does the `codeql-extractor-iac` support?

The `codeql-extractor-iac` is a community extractor and supports a number of frameworks and technologies. The following table lists the supported frameworks and technologies:

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

**Support Levels:**

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

## Q: How can I get support for a new framework or technology?

If a framework or technology is not listed above and you would like to see it supported, [please open an issue](https://github.com/advanced-security/codeql-extractor-iac/issues).

## Q: What Operating Systems does the `codeql-extractor-iac` support?

The `codeql-extractor-iac` is a community extractor and supports the following operating systems:

- Linux (Ubuntu / Debian tested)

In the future other operating systems may be supported.

## Q: What can I do to support this project?

We are always looking for help and support from the community.
Everything from staring on GitHub to updating documentation to contributing code is greatly appreciated!

<!-- Resources -->

[Issues]: https://github.com/advanced-security/codeql-extractor-iac/issues
[Discussions]: https://github.com/advanced-security/codeql-extractor-iac/discussions
[CodeQL]: https://codeql.github.com
[GitHub Advanced Security]: https://github.com/features/security
