/**
 * Classes and predicates for analyzing HCL attribute expressions.
 * Attributes represent key-value assignments within blocks and handle
 * reference resolution for variables, resources, and data sources.
 */

import codeql.iac.ast.internal.TreeSitter
import codeql.iac.ast.internal.Hcl
import codeql.hcl.AST
import codeql.hcl.ast.AstNodes
import codeql.hcl.Resources

/**
 * An attribute in HCL code.
 *
 * Attributes represent key-value assignments within blocks. They define configuration
 * parameters, settings, and properties for resources, data sources, variables, and
 * other block types. Attributes can contain literal values, expressions, or references
 * to other resources and variables.
 *
 * This class also provides reference resolution capabilities, automatically resolving
 * variable references, resource attribute access, and data source lookups to their
 * corresponding definitions.
 *
 * Example HCL attributes:
 * ```
 * resource "aws_instance" "web" {
 *   ami           = "ami-12345678"              // Simple attribute with string literal
 *   instance_type = var.instance_type          // Attribute with variable reference
 *   subnet_id     = aws_subnet.main.id         // Attribute with resource reference
 *   vpc_id        = data.aws_vpc.default.id    // Attribute with data source reference
 *
 *   tags = {                                   // Attribute with object value
 *     Name        = "WebServer"
 *     Environment = var.environment
 *   }
 * }
 *
 * variable "instance_type" {
 *   description = "EC2 instance type"          // Attribute with description
 *   type        = string                       // Attribute with type constraint
 *   default     = "t2.micro"                   // Attribute with default value
 * }
 * ```
 */
class Attribute extends Expr, TAttribute {
  private HCL::Attribute attribute;

  Attribute() { this = TAttribute(attribute) }

  override string getAPrimaryQlClass() { result = "Attribute" }

  /** Gets the key (name) of this attribute as an identifier. */
  Identifier getKey() { toHclTreeSitter(result) = attribute.getKey() }

  /**
   * Gets the value expression of this attribute.
   *
   * This may return either the direct value or a resolved reference
   * if the attribute contains variable, resource, or data source references.
   */
  Expr getExpr() {
    result = this.getReference() or
    toHclTreeSitter(result) = attribute.getVal()
  }

  /**
   * Gets the resolved reference for this attribute, if it contains one.
   *
   * This predicate handles automatic resolution of:
   * - Variable references (var.name) to their default values
   * - Resource attribute references (resource.name.attribute) to the corresponding resource attributes
   * - Data source references (data.type.name.attribute) to the corresponding data source attributes
   *
   * Returns the resolved expression if a reference is found, or fails if the attribute
   * contains a literal value or unresolvable reference.
   */
  Expr getReference() {
    exists(GetAttrExpr e | e = this.getExpr() |
      (
        // variable / var lookup
        // Example: var.name
        e.getExpr().(Variable).getName() = "var" and
        exists(Block var |
          var.getType() = "variable" and var.getLabel(0) = e.getKey().(Identifier).getName()
        |
          result = var.getAttribute("default")
        )
        or
        // TODO: data lookup
        // resource lookup
        // Example: resource.name.attribute
        exists(Resource resources |
          // resource
          resources.getResourceType() = e.getExpr().(GetAttrExpr).getExpr().(Variable).getName() and
          // resource name
          resources.getLabel(1) = e.getExpr().(GetAttrExpr).getKey().(Identifier).getName()
        |
          // resource attribute key
          // ID attribute return the resource itself
          e.getKey().(Identifier).getName() = "id" and
          result = resources
          or
          // get attribute in resource
          result = resources.getAttribute(e.getKey().(Identifier).getName())
        )
      )
    )
  }
}
