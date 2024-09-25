private import codeql.iac.ast.internal.Bicep
private import codeql.bicep.ast.internal.AstNodes
private import codeql.bicep.ast.internal.Expr

/**
 * A Bicep for loop statement.
 */
class ForStatementImpl extends ExprImpl, TForExpression {
  BICEP::ForStatement fexpr;

  override string getAPrimaryQlClass() { result = "ForStatement" }

  ForStatementImpl() { this = TForExpression(fexpr) }

  IdentifierImpl getInitializer() { toBicepTreeSitter(result) = fexpr.getInitializer() }

  ExprImpl getCondition() {
    // TODO
    none()
  }

  ExprImpl getBody() { toBicepTreeSitter(result) = fexpr.getBody() }
}

/**
 */
class LoopEnumeratorImpl extends ExprImpl, TLoopEnumerator {
  private BICEP::LoopEnumerator lenum;

  override string getAPrimaryQlClass() { result = "LoopEnumerator" }

  LoopEnumeratorImpl() { this = TLoopEnumerator(lenum) }
}

/**
 * A Bicep loop variable.
 */
class LoopVariableImpl extends ExprImpl, TLoopVariable {
  private BICEP::LoopVariable lvar;

  override string getAPrimaryQlClass() { result = "LoopVariable" }

  LoopVariableImpl() { this = TLoopVariable(lvar) }
}
