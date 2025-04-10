/**
 * Literals in the AST.
 */

private import AstNodes
private import internal.AstNodes
private import internal.TreeSitter
private import internal.Literals
private import internal.Null
private import internal.NullableReturnType
private import internal.String
private import internal.StringContent

/**
 * A literal in the AST.
 */
final class Literals extends AstNode instanceof LiteralsImpl { }

/**
 * A Null literal in the AST.
 */
final class NullLiteral extends Literals instanceof NullImpl {
}
/**
 * A NullableReturnType literal in the AST.
 */
final class NullableReturnTypeLiteral extends Literals instanceof NullableReturnTypeImpl {
}

/**
 * A String literal in the AST.
 */
final class StringLiteral extends Literals instanceof StringImpl {
    string getString() { result = super.getValue() }
}
/**
 * A StringContent literal in the AST.
 */
final class StringContentLiteral extends Literals instanceof StringContentImpl {
}