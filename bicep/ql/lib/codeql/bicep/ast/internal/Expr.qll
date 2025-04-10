private import codeql.bicep.ast.AstNodes
private import AstNodes
private import TreeSitter

/**
 * A Bicep expression.
 */
class ExprImpl extends AstNode, TExpr {
  override string getAPrimaryQlClass() { result = "Expr" }
}
