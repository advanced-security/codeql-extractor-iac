/**
 *  Internal implementation for String
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Literals


/**
 *  A String AST Node.
 */
class StringImpl extends TString, LiteralsImpl {
  private BICEP::String ast;

  override string getAPrimaryQlClass() { result = "String" }

  StringImpl() { this = TString(ast) }

  override string toString() { result = ast.toString() }
  /**
   *  Get the literal value
   * 
   *  TODO: This is broken.
   */
  override string getValue() { result = ast.getChild(_).toString() }



}