/**
 * Comprehensive analysis capabilities for HCL (HashiCorp Configuration Language) files.
 * This library includes AST analysis, resource definitions, security checks, provider-specific
 * functionality, and support for Terraform configurations.
 *
 * The library offers the following main components:
 * - AST nodes and expressions for analyzing HCL syntax and structure
 * - Resource and data source analysis for infrastructure components
 * - Variable, local, and constant value tracking
 * - Provider-specific classes for AWS, Azure, GCP, and other cloud providers
 * - Security analysis for detecting hardcoded secrets and misconfigurations
 * - Terraform-specific functionality for modules, state, and workflows
 */

import codeql.Locations
import codeql.files.FileSystem
import codeql.hcl.ast.AstNodes
import codeql.hcl.Resources
import codeql.hcl.Constants
import codeql.hcl.Locals
import codeql.hcl.Terraform
// providers
import codeql.hcl.Providers
// security
import codeql.hcl.Security
