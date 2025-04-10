/**
 *  Internal implementation for Object
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A Object AST Node.
 */
class ObjectImpl extends TObject, AstNode {
  private BICEP::Object ast;

  override string getAPrimaryQlClass() { result = "Object" }

  ObjectImpl() { this = TObject(ast) }

  override string toString() { result = ast.toString() }



}