private import codeql.Locations
private import codeql.files.FileSystem
private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.Literals
private import codeql.hcl.ast.Variables

/** An AST node of a IAC program */
class HclAstNode extends THclAstNode {
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
  HclAstNode getParent() { result.getAChild(_) = this }

  /**
   * Gets a child of this node, which can also be retrieved using a predicate
   * named `pred`.
   */
  cached
  HclAstNode getAChild(string pred) { none() }

  /** Gets any child of this node. */
  HclAstNode getAChild() { result = this.getAChild(_) }

  /**
   * Gets the primary QL class for the ast node.
   */
  string getAPrimaryQlClass() { result = "???" }
}

class Comment extends HclAstNode, TComment {
  private HCL::Comment comment;

  override string getAPrimaryQlClass() { result = "Comment" }

  Comment() { this = TComment(comment) }

  string getContents() { result = comment.getValue() }
}

class Expr extends HclAstNode, TExpr {
  override string getAPrimaryQlClass() { result = "Expr" }
}

class BinaryOperation extends Expr {
  HCL::BinaryOperation binaryOp;

  override string getAPrimaryQlClass() { result = "BinaryOperation" }

  BinaryOperation() { this = TBinaryOperation(binaryOp) }

  Expr getLeftOperand() { toHclTreeSitter(result) = binaryOp.getLeft() }

  Expr getRightOperand() { toHclTreeSitter(result) = binaryOp.getRight() }

  string getOperator() { result = binaryOp.getOperator() }

  override string toString() {
    result = this.getLeftOperand() + " " + this.getOperator() + " " + this.getRightOperand()
  }

  override HclAstNode getAChild(string pred) {
    pred = "getLeftOperand" and result = this.getLeftOperand()
    or
    pred = "getRightOperand" and result = this.getRightOperand()
  }
}

class Identifier extends Expr, TIdentifier {
  private HCL::Identifier identifier;

  override string getAPrimaryQlClass() { result = "Identifier" }

  Identifier() { this = TIdentifier(identifier) }

  string getName() { result = identifier.getValue() }
}

class Object extends Expr, TObject {
  private HCL::Object object;

  override string getAPrimaryQlClass() { result = "Object" }

  Object() { this = TObject(object) }

  ObjectElement getElement(int index) { toHclTreeSitter(result) = object.getElement(index) }

  ObjectElement getElements() { toHclTreeSitter(result) = object.getElement(_) }

  Expr getElementByName(string name) {
    exists(ObjectElement elem | this.getElements() = elem |
      elem.getKey().getName() = name and
      result = elem.getExpr()
    )
  }
}

class ObjectElement extends Expr, TObjectElem {
  private HCL::ObjectElem objectElem;

  override string getAPrimaryQlClass() { result = "ObjectElement" }

  ObjectElement() { this = TObjectElem(objectElem) }

  Variable getKey() { toHclTreeSitter(result) = objectElem.getKey() }

  Expr getExpr() { toHclTreeSitter(result) = objectElem.getVal() }
}

class Tuple extends Expr, TTuple {
  private HCL::Tuple tuple;

  override string getAPrimaryQlClass() { result = "Tuple" }

  Tuple() { this = TTuple(tuple) }

  Expr getElement(int i) { toHclTreeSitter(result) = tuple.getElement(i) }
}

class HereDoc extends Expr, THeredocTemplate {
  private HCL::HeredocTemplate hereDoc;

  HereDoc() { this = THeredocTemplate(hereDoc) }
}
