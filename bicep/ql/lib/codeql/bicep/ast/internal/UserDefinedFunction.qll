/**
 *  Internal implementation for UserDefinedFunction
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A UserDefinedFunction AST Node.
 */
class UserDefinedFunctionImpl extends TUserDefinedFunction, AstNode {
  private BICEP::UserDefinedFunction ast;

  override string getAPrimaryQlClass() { result = "UserDefinedFunction" }

  UserDefinedFunctionImpl() { this = TUserDefinedFunction(ast) }

  override string toString() { result = ast.toString() }



}