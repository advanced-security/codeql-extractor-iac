private import codeql.iac.ast.internal.Bicep
private import codeql.bicep.ast.internal.AstNodes

/**
 * A Bicep expression.
 */
class ExprImpl extends BicepAstNode, TExpr {
  override string getAPrimaryQlClass() { result = "Expr" }
}

/**
 * A Bicep identifier.
 */
class IdentifierImpl extends ExprImpl, TIdentifier {
  private BICEP::Identifier identifier;

  override string getAPrimaryQlClass() { result = "Identifier" }

  IdentifierImpl() { this = TIdentifier(identifier) }

  override string toString() { result = this.getName() }

  string getName() { result = identifier.getValue() }
}

/**
 * A Bicep expression.
 */
class ExpressionImpl extends ExprImpl, TExpression {
  private BICEP::Expression expression;

  override string getAPrimaryQlClass() { result = "Expression" }

  ExpressionImpl() { this = TExpression(expression) }
}

/**
 * A Binary assignment expression.
 */
class AssignmentExprImpl extends ExprImpl, TAssignmentExpression {
  BICEP::AssignmentExpression aexpr;

  override string getAPrimaryQlClass() { result = "AssignmentExpr" }

  AssignmentExprImpl() { this = TAssignmentExpression(aexpr) }
}

class BinaryExprImpl extends ExprImpl, TBinaryExpression {
  BICEP::BinaryExpression bexpr;

  override string getAPrimaryQlClass() { result = "BinaryExpr" }

  BinaryExprImpl() { this = TBinaryExpression(bexpr) }
}

class MemberExprImpl extends ExprImpl, TMemberExpression {
  BICEP::MemberExpression mexpr;

  override string getAPrimaryQlClass() { result = "MemberExpr" }

  MemberExprImpl() { this = TMemberExpression(mexpr) }

  ExprImpl getObject() { toBicepTreeSitter(result) = mexpr.getObject() }

  PropertyIdentifierImpl getProperty() { toBicepTreeSitter(result) = mexpr.getProperty() }
}

class ParenthesizedExprImpl extends ExprImpl, TParenthesizedExpression {
  BICEP::ParenthesizedExpression pexpr;

  override string getAPrimaryQlClass() { result = "ParenthesizedExpr" }

  ParenthesizedExprImpl() { this = TParenthesizedExpression(pexpr) }
}

class ResourceExprImpl extends ExprImpl, TResourceExpression {
  BICEP::ResourceExpression rexpr;

  override string getAPrimaryQlClass() { result = "ResourceExpr" }

  ResourceExprImpl() { this = TResourceExpression(rexpr) }
}

class SubscriptExprImpl extends ExprImpl, TSubscriptExpression {
  BICEP::SubscriptExpression sexpr;

  override string getAPrimaryQlClass() { result = "SubscriptExpr" }

  SubscriptExprImpl() { this = TSubscriptExpression(sexpr) }
}

class TerenaryExprImpl extends ExprImpl, TTernaryExpression {
  BICEP::TernaryExpression texpr;

  override string getAPrimaryQlClass() { result = "TerenaryExpr" }

  TerenaryExprImpl() { this = TTernaryExpression(texpr) }
}

class UnaryExprImpl extends ExprImpl, TUnaryExpression {
  BICEP::UnaryExpression uexpr;

  override string getAPrimaryQlClass() { result = "UnaryExpr" }

  UnaryExprImpl() { this = TUnaryExpression(uexpr) }
}

class PropertyIdentifierImpl extends ExprImpl, TPropertyIdentifier {
  BICEP::PropertyIdentifier pidentifier;

  override string getAPrimaryQlClass() { result = "PropertyIdentifier" }

  PropertyIdentifierImpl() { this = TPropertyIdentifier(pidentifier) }

  override string toString() { result = this.getName() }

  string getName() { result = pidentifier.getValue() }
}

class DecoratorImpl extends ExprImpl, TDecorator {
  private BICEP::Decorator decorator;

  override string getAPrimaryQlClass() { result = "Decorator" }

  DecoratorImpl() { this = TDecorator(decorator) }
}
