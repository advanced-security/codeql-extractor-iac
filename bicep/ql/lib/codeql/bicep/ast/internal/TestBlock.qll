/**
 *  Internal implementation for TestBlock
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes

/**
 *  A TestBlock AST Node.
 */
class TestBlockImpl extends TTestBlock, AstNode {
  private BICEP::TestBlock ast;

  override string getAPrimaryQlClass() { result = "TestBlock" }

  TestBlockImpl() { this = TTestBlock(ast) }

  override string toString() { result = ast.toString() }



}