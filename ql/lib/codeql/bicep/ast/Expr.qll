private import codeql.bicep.ast.internal.AstNodes
private import codeql.bicep.ast.internal.Expr

/**
 * A Bicep expression.
 */
final class Expr extends BicepAstNode instanceof ExprImpl { }

/**
 * A Bicep identifier.
 */
final class Identifier extends Expr instanceof IdentifierImpl {
  string getName() { result = super.getName() }
}

/**
 * A Bicep expression.
 */
final class Expression extends Expr instanceof ExpressionImpl { }

/**
 * A Binary assignment expression.
 */
final class AssignmentExpr extends Expr instanceof AssignmentExprImpl { }

final class BinaryExpr extends Expr instanceof BinaryExprImpl { }

final class MemberExpr extends Expr instanceof MemberExprImpl {
  Expr getObject() { result = super.getObject() }

  PropertyIdentifier getProperty() { result = super.getProperty() }
}

final class ParenthesizedExpr extends Expr instanceof ParenthesizedExprImpl { }

final class ResourceExpr extends Expr instanceof ResourceExprImpl { }

final class SubscriptExpr extends Expr instanceof SubscriptExprImpl { }

final class TerenaryExpr extends Expr instanceof TerenaryExprImpl { }

final class UnaryExpr extends Expr instanceof UnaryExprImpl { }

/**
 * A Bicept Property Identifier.
 */
final class PropertyIdentifier extends Expr instanceof PropertyIdentifierImpl {
  string getName() { result = super.getName() }
}

final class Decorator extends Expr instanceof DecoratorImpl { }
