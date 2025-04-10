/**
 *  Internal implementation for StringContent
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Literals


/**
 *  A StringContent AST Node.
 */
class StringContentImpl extends TStringContent, LiteralsImpl {
  private BICEP::StringContent ast;

  override string getAPrimaryQlClass() { result = "StringContent" }

  StringContentImpl() { this = TStringContent(ast) }

  override string toString() { result = ast.toString() }
  /**
   *  Get the literal value
   */
  override string getValue() { result = ast.getValue() }



}