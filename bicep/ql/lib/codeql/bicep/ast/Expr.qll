private import AstNodes
private import internal.AstNodes
private import internal.TreeSitter
private import internal.Expr
private import internal.AssignmentExpression
private import internal.BinaryExpression
private import internal.CallExpression
private import internal.Expression
private import internal.Interpolation
private import internal.LambdaExpression
private import internal.MemberExpression
private import internal.NullableType
private import internal.ParenthesizedExpression
private import internal.PrimaryExpression
private import internal.ResourceExpression
private import internal.SubscriptExpression
private import internal.TernaryExpression
private import internal.UnaryExpression

/**
 * An expression in the AST.
 */
final class Expr extends AstNode instanceof ExprImpl { }

/**
 * A AssignmentExpression expression in the AST.
 */
final class AssignmentExpressionExpr extends Expr instanceof AssignmentExpressionImpl { }

/**
 * A BinaryExpression expression in the AST.
 */
final class BinaryExpressionExpr extends Expr instanceof BinaryExpressionImpl { }

/**
 * A CallExpression expression in the AST.
 */
final class CallExpressionExpr extends Expr instanceof CallExpressionImpl { }

/**
 * A Expression expression in the AST.
 */
final class ExpressionExpr extends Expr instanceof ExpressionImpl { }

/**
 * A Interpolation literal in the AST.
 */
final class InterpolationLiteral extends Expr instanceof InterpolationImpl { }

/**
 * A LambdaExpression expression in the AST.
 */
final class LambdaExpressionExpr extends Expr instanceof LambdaExpressionImpl { }

/**
 * A MemberExpression expression in the AST.
 */
final class MemberExpressionExpr extends Expr instanceof MemberExpressionImpl { }

/**
 * A NullableType literal in the AST.
 */
final class NullableTypeLiteral extends Expr instanceof NullableTypeImpl { }

/**
 * A ParenthesizedExpression expression in the AST.
 */
final class ParenthesizedExpressionExpr extends Expr instanceof ParenthesizedExpressionImpl { }

/**
 * A PrimaryExpression expression in the AST.
 */
final class PrimaryExpressionExpr extends Expr instanceof PrimaryExpressionImpl { }

/**
 * A ResourceExpression expression in the AST.
 */
final class ResourceExpressionExpr extends Expr instanceof ResourceExpressionImpl { }

/**
 * A SubscriptExpression expression in the AST.
 */
final class SubscriptExpressionExpr extends Expr instanceof SubscriptExpressionImpl { }

/**
 * A TernaryExpression expression in the AST.
 */
final class TernaryExpressionExpr extends Expr instanceof TernaryExpressionImpl { }

/**
 * A UnaryExpression expression in the AST.
 */
final class UnaryExpressionExpr extends Expr instanceof UnaryExpressionImpl { }
