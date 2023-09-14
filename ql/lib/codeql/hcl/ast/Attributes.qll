import codeql.iac.ast.internal.TreeSitter
import codeql.iac.ast.internal.Hcl
import codeql.hcl.AST
import codeql.hcl.ast.AstNodes
import codeql.hcl.Resources

/**
 * A Terraform attribute.
 */
class Attribute extends Expr, TAttribute {
  private HCL::Attribute attribute;

  Attribute() { this = TAttribute(attribute) }

  override string getAPrimaryQlClass() { result = "Attribute" }

  Identifier getKey() { toHclTreeSitter(result) = attribute.getKey() }

  Expr getExpr() {
    result = this.getReference() or
    toHclTreeSitter(result) = attribute.getVal()
  }

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
