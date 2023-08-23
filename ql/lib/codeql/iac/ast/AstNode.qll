private import codeql.iac.ast.internal.AstNodes
private import codeql.Locations
private import codeql.files.FileSystem

module HCL {
  /** An AST node of a IAC program */
  class AstNode extends THclAstNode {
    string toString() { result = this.getAPrimaryQlClass() }

    /** Gets the location of the AST node. */
    cached
    Location getLocation() { result = this.getFullLocation() } // overridden in some subclasses

    /** Gets the file containing this AST node. */
    cached
    File getFile() { result = this.getFullLocation().getFile() }

    /** Gets the location that spans the entire AST node. */
    cached
    final Location getFullLocation() { result = toHclTreeSitter(this).getLocation() }

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
}

module Containers {
  /** An AST node of a IAC program */
  class AstNode extends TContainerAstNode {
    string toString() { result = this.getAPrimaryQlClass() }

    /** Gets the location of the AST node. */
    cached
    Location getLocation() { result = this.getFullLocation() } // overridden in some subclasses

    /** Gets the file containing this AST node. */
    cached
    File getFile() { result = this.getFullLocation().getFile() }

    /** Gets the location that spans the entire AST node. */
    cached
    final Location getFullLocation() { result = toContainerTreeSitter(this).getLocation() }

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
}
