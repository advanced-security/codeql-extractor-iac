private import codeql.bicep.ast.Ast
private import codeql.bicep.ast.internal.Loops
private import codeql.bicep.ast.Expr

/**
 * A Bicep loop statement.
 */
final class ForStatement extends Expr instanceof ForStatementImpl {
  Identifier getInitializer() { result = super.getInitializer() }

  Expr getCondition() { result = super.getCondition() }

  Expr getBody() { result = super.getBody() }
}

/**
 * A Bicep loop enumerator.
 */
final class LoopEnumerator extends Expr instanceof LoopEnumeratorImpl { }

/**
 * A Bicep loop variable.
 */
final class LoopVariable extends Expr instanceof LoopVariableImpl { }
