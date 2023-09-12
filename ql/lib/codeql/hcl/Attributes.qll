import codeql.iac.ast.internal.TreeSitter
import codeql.iac.ast.internal.Hcl
import codeql.hcl.AST
import codeql.hcl.ast.AstNodes
import codeql.hcl.Resources

private Expr getAttributeRef(Attribute attr) {
  exists(GetAttrExpr e | e = attr.getExpr() |
    // variable / var
    e.getExpr().(Variable).getName() = "var" and
    exists(Block var |
      var.getType() = "variable" and var.getLabel(0) = e.getKey().(Identifier).getName()
    |
      result = var.getAttribute("default")
    )
    or
    // resource lookup
    exists(Resource resources |
      resources.getResourceType() = e.getExpr().(GetAttrExpr).getExpr().(Variable).getName() and
      resources.getLabel(1) = e.getExpr().(GetAttrExpr).getKey().(Identifier).getName()
    |
      // correct
      result = resources.getAttribute(e.getKey().(Identifier).getName())
    )
  )
}

/**
 * A Terraform attribute.
 */
class Attribute extends Expr, TAttribute {
  private HCL::Attribute attribute;
  private Expr reference;

  Attribute() { this = TAttribute(attribute) or reference = getAttributeRef(this) }

  override string getAPrimaryQlClass() { result = "Attribute" }

  override string toString() {
    result = this.getKey().getName() + " = " + this.getExpr().toString()
  }

  Identifier getKey() { toHclTreeSitter(result) = attribute.getKey() }

  Expr getExpr() { result = reference or toHclTreeSitter(result) = attribute.getVal() }

  Expr getReference() { result = reference }
}
