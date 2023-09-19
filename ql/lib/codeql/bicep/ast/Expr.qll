private import codeql.iac.ast.internal.Bicep
private import codeql.bicep.ast.AstNodes

class Expr extends BicepAstNode, TExpr {
  override string getAPrimaryQlClass() { result = "Expr" }
}

class Identifier extends Expr, TIdentifier {
  private BICEP::Identifier identifier;

  override string getAPrimaryQlClass() { result = "Identifier" }

  Identifier() { this = TIdentifier(identifier) }

  override string toString() { result = this.getName() }

  string getName() { result = identifier.getValue() }
}

class Expression extends Expr, TExpression {
  private BICEP::Expression expression;

  override string getAPrimaryQlClass() { result = "Expression" }

  Expression() { this = TExpression(expression) }
}

class AssignmentExpr extends Expr, TAssignmentExpression {
  BICEP::AssignmentExpression aexpr;

  override string getAPrimaryQlClass() { result = "AssignmentExpr" }

  AssignmentExpr() { this = TAssignmentExpression(aexpr) }
}

class BinaryExpr extends Expr, TBinaryExpression {
  BICEP::BinaryExpression bexpr;

  override string getAPrimaryQlClass() { result = "BinaryExpr" }

  BinaryExpr() { this = TBinaryExpression(bexpr) }
}

class CallExpr extends Expr, TCallExpression {
  BICEP::CallExpression cexpr;

  override string getAPrimaryQlClass() { result = "CallExpr" }

  CallExpr() { this = TCallExpression(cexpr) }
}

class LambdaExpr extends Expr, TLambdaExpression {
  BICEP::LambdaExpression lexpr;

  override string getAPrimaryQlClass() { result = "LambdaExpr" }

  LambdaExpr() { this = TLambdaExpression(lexpr) }
}

class MemberExpr extends Expr, TMemberExpression {
  BICEP::MemberExpression mexpr;

  override string getAPrimaryQlClass() { result = "MemberExpr" }

  MemberExpr() { this = TMemberExpression(mexpr) }
}

class ParenthesizedExpr extends Expr, TParenthesizedExpression {
  BICEP::ParenthesizedExpression pexpr;

  override string getAPrimaryQlClass() { result = "ParenthesizedExpr" }

  ParenthesizedExpr() { this = TParenthesizedExpression(pexpr) }
}

class ResourceExpr extends Expr, TResourceExpression {
  BICEP::ResourceExpression rexpr;

  override string getAPrimaryQlClass() { result = "ResourceExpr" }

  ResourceExpr() { this = TResourceExpression(rexpr) }
}

class SubscriptExpr extends Expr, TSubscriptExpression {
  BICEP::SubscriptExpression sexpr;

  override string getAPrimaryQlClass() { result = "SubscriptExpr" }

  SubscriptExpr() { this = TSubscriptExpression(sexpr) }
}

class TerenaryExpr extends Expr, TTernaryExpression {
  BICEP::TernaryExpression texpr;

  override string getAPrimaryQlClass() { result = "TerenaryExpr" }

  TerenaryExpr() { this = TTernaryExpression(texpr) }
}

class UnaryExpr extends Expr, TUnaryExpression {
  BICEP::UnaryExpression uexpr;

  override string getAPrimaryQlClass() { result = "UnaryExpr" }

  UnaryExpr() { this = TUnaryExpression(uexpr) }
}
