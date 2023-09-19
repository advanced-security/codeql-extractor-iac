import codeql.iac.ast.internal.Bicep
import codeql.bicep.ast.AstNodes

class Expr extends BicepAstNode, TExpr {
  override string getAPrimaryQlClass() { result = "Expr" }
}

class AssignmentExpr extends Expr {
  BICEP::AssignmentExpression aexpr;

  override string getAPrimaryQlClass() { result = "AssignmentExpr" }

  AssignmentExpr() { this = TAssignmentExpression(aexpr) }
}

class BinaryExpr extends Expr {
  BICEP::BinaryExpression bexpr;

  override string getAPrimaryQlClass() { result = "BinaryExpr" }

  BinaryExpr() { this = TBinaryExpression(bexpr) }
}

class CallExpr extends Expr {
  BICEP::CallExpression cexpr;

  override string getAPrimaryQlClass() { result = "CallExpr" }

  CallExpr() { this = TCallExpression(cexpr) }
}

class LambdaExpr extends Expr {
  BICEP::LambdaExpression lexpr;

  override string getAPrimaryQlClass() { result = "LambdaExpr" }

  LambdaExpr() { this = TLambdaExpression(lexpr) }
}

class MemberExpr extends Expr {
  BICEP::MemberExpression mexpr;

  override string getAPrimaryQlClass() { result = "MemberExpr" }

  MemberExpr() { this = TMemberExpression(mexpr) }
}

class ParenthesizedExpr extends Expr {
  BICEP::ParenthesizedExpression pexpr;

  override string getAPrimaryQlClass() { result = "ParenthesizedExpr" }

  ParenthesizedExpr() { this = TParenthesizedExpression(pexpr) }
}

class PrimaryExpr extends Expr {
  BICEP::PrimaryExpression pexpr;

  override string getAPrimaryQlClass() { result = "PrimaryExpr" }

  PrimaryExpr() { this = TPrimaryExpression(pexpr) }
}

class ResourceExpr extends Expr {
  BICEP::ResourceExpression rexpr;

  override string getAPrimaryQlClass() { result = "ResourceExpr" }

  ResourceExpr() { this = TResourceExpression(rexpr) }
}

class SubscriptExpr extends Expr {
  BICEP::SubscriptExpression sexpr;

  override string getAPrimaryQlClass() { result = "SubscriptExpr" }

  SubscriptExpr() { this = TSubscriptExpression(sexpr) }
}

class TerenaryExpr extends Expr {
  BICEP::TernaryExpression texpr;

  override string getAPrimaryQlClass() { result = "TerenaryExpr" }

  TerenaryExpr() { this = TTernaryExpression(texpr) }
}

class UnaryExpr extends Expr {
  BICEP::UnaryExpression uexpr;

  override string getAPrimaryQlClass() { result = "UnaryExpr" }

  UnaryExpr() { this = TUnaryExpression(uexpr) }
}
