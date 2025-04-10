
/**
 * Conditional statements.
 */
private import codeql.bicep.ast.AstNodes
private import AstNodes
private import TreeSitter
private import Expr

/**
 * Conditional statements.
 */
class ConditionalExprImpl extends ExprImpl, TConditionalExpr {
  override string getAPrimaryQlClass() { result = "Conditional" }

  abstract ExprImpl getCondition();
}