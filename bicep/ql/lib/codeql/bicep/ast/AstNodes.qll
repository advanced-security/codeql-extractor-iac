private import codeql.Locations
private import codeql.files.FileSystem
private import codeql.bicep.ast.internal.AstNodes
private import codeql.bicep.ast.internal.TreeSitter

/**
 * An AST node of a Bicep program
 */
class AstNode extends TAstNode {
  string toString() { result = this.getAPrimaryQlClass() }

  /** Gets the location of the AST node. */
  cached
  Location getLocation() { result = this.getFullLocation() } // overridden in some subclasses

  /** Gets the file containing this AST node. */
  cached
  File getFile() { result = this.getFullLocation().getFile() }

  /** Gets the location that spans the entire AST node. */
  cached
  final Location getFullLocation() { result = toTreeSitter(this).getLocation() }

  predicate hasLocationInfo(
    string filepath, int startline, int startcolumn, int endline, int endcolumn
  ) {
    if exists(this.getLocation())
    then this.getLocation().hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
    else (
      filepath = "" and
      startline = 0 and
      startcolumn = 0 and
      endline = 0 and
      endcolumn = 0
    )
  }

  /**
   * Gets the parent in the AST for this node.
   */
  cached
  AstNode getParent() { result.getAChild(_) = this }

  /**
   * Gets a child of this node, which can also be retrieved using a predicate
   * named `pred`.
   */
  cached
  AstNode getAChild(string pred) { none() }

  /** Gets any child of this node. */
  AstNode getAChild() { result = this.getAChild(_) }

  /**
   * Gets the primary QL class for the ast node.
   */
  string getAPrimaryQlClass() { result = "???" }
}

/** A Bicep file */
class BicepFile extends File {
  BicepFile() { exists(Location loc | bicep_ast_node_location(_, loc) and this = loc.getFile()) }

  /** Gets a token in this file. */
  private BICEP::Token getAToken() { result.getLocation().getFile() = this }

  /** Holds if `line` contains a token. */
  private predicate line(int line) {
    exists(BICEP::Token token, Location l |
      token = this.getAToken() and
      l = token.getLocation() and
      line in [l.getStartLine() .. l.getEndLine()]
    )
  }

  /** Gets the number of lines in this file. */
  int getNumberOfLines() { result = max([0, this.getAToken().getLocation().getEndLine()]) }

  /** Gets the number of lines of code in this file. */
  int getNumberOfLinesOfCode() { result = count(int line | this.line(line)) }
}

/**
 * A comment in a Bicep program
 */
class Comment extends AstNode, TComment {
  private BICEP::Comment comment;

  override string getAPrimaryQlClass() { result = "Comment" }

  Comment() { this = TComment(comment) }

  /**
   * Gets the text of the comment.
   *
   * TODO: Implement this method
   */
  string getContents() { result = "" }
}
