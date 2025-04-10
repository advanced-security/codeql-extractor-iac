private import codeql.bicep.ast.AstNodes
private import AstNodes
private import TreeSitter

/**
 * Literal statements.
 */
class LiteralsImpl extends AstNode, TLiterals {
  override string getAPrimaryQlClass() { result = "Literals" }

  /** Get the value of the literal */
  abstract string getValue();
}
