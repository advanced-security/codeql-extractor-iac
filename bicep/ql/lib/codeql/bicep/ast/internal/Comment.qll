/**
 *  Internal implementation for Comment
 *
 *  WARNING: this file is generated, do not edit manually
 */
private import AstNodes
private import TreeSitter
private import codeql.bicep.ast.AstNodes
private import Comment


/**
 *  A Comment AST Node.
 */
class CommentImpl extends TComment, CommentImpl {
  private BICEP::Comment ast;

  override string getAPrimaryQlClass() { result = "Comment" }

  CommentImpl() { this = TComment(ast) }

  override string toString() { result = ast.toString() }



}