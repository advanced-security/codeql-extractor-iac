private import codeql.iac.ast.internal.AstNodes
private import codeql.iac.ast.AstNode::HCL
private import codeql.Locations
private import codeql.files.FileSystem

class Comment extends AstNode, TComment {
  private HCL::Comment comment;

  override string getAPrimaryQlClass() { result = "Comment" }

  Comment() { this = TComment(comment) }

  string getContents() { result = comment.getValue() }
}

class Identifier extends AstNode, TIdentifier {
  private HCL::Identifier identifier;

  override string getAPrimaryQlClass() { result = "Identifier" }

  Identifier() { this = TIdentifier(identifier) }

  string getName() { result = identifier.getValue() }
}

class Expr extends AstNode, TExpr {
  override string getAPrimaryQlClass() { result = "Expr" }
}

class Literal extends Expr, TLiteral {
  @hcl_underscore_literal_value literal;

  override string getAPrimaryQlClass() { result = "Literal" }

  Literal() { literal = toHclTreeSitter(this) }

  string getValue() { none() }

  override string toString() { result = this.getValue() }
}

class StringLiteral extends Literal, TStringLit {
  override HCL::StringLit literal;

  override string getAPrimaryQlClass() { result = "StringLiteral" }

  StringLiteral() { this = TStringLit(literal) }

  override string getValue() { result = literal.getChild().getValue() }
}

class NumericLiteral extends Literal, TNumericLit {
  override HCL::NumericLit literal;

  override string getAPrimaryQlClass() { result = "NumericLiteral" }

  NumericLiteral() { this = TNumericLit(literal) }

  override string getValue() { result = literal.getValue() }
}

class BooleanLiteral extends Literal, TBooleanLiteral {
  override HCL::BoolLit literal;

  override string getAPrimaryQlClass() { result = "BooleanLiteral" }

  BooleanLiteral() { this = TBooleanLiteral(literal) }

  override string getValue() { result = literal.getValue() }

  boolean getBool() { result.toString() = literal.getValue() }
}

class NullLiteral extends Literal, TNullLiteral {
  override HCL::NullLit literal;

  override string getAPrimaryQlClass() { result = "NullLiteral" }

  NullLiteral() { this = TNullLiteral(literal) }

  override string getValue() { result = literal.getValue() }
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

  override AstNode getAChild(string pred) {
    pred = "getLeftOperand" and result = this.getLeftOperand()
    or
    pred = "getRightOperand" and result = this.getRightOperand()
  }
}

class Block extends Expr, TBlock {
  HCL::Block block;

  override string getAPrimaryQlClass() { result = "Block" }

  Block() { this = TBlock(block) }

  string getType() { result = block.getType().getValue() }

  predicate hasType(string type) { type = this.getType() }

  override string toString() { result = this.getType() }

  Block getABlock() { toHclTreeSitter(result) = block.getBody().getChild(_) }

  string getLabel(int i) {
    result = block.getLabel(i).(HCL::Identifier).getValue() or
    result = block.getLabel(i).(HCL::StringLit).getChild().getValue()
  }

  predicate hasLabel(int i, string label) { label = this.getLabel(i) }

  override AstNode getAChild(string pred) {
    pred = "getABlock" and result = this.getABlock()
    or
    pred = "getAttribute" and result = this.getAttribute(_)
  }

  Expr getAttribute(string name) {
    exists(HCL::Attribute attr | attr = block.getBody().getChild(_) |
      attr.getKey().getValue() = name and
      toHclTreeSitter(result) = attr.getVal()
    )
    or
    result = this.getABlock() and result.(Block).hasType(name)
  }

  predicate hasAttribute(string name) {
    exists(HCL::Attribute attr | attr = block.getBody().getChild(_) |
      attr.getKey().getValue() = name
    )
  }
}

class Object extends Expr, TObject {
  HCL::Object object;

  override string getAPrimaryQlClass() { result = "Object" }

  Object() { this = TObject(object) }
}

class Tuple extends Expr, TTuple {
  HCL::Tuple tuple;

  override string getAPrimaryQlClass() { result = "Tuple" }

  Tuple() { this = TTuple(tuple) }

  Expr getElement(int i) { toHclTreeSitter(result) = tuple.getElement(i) }
}

class FunctionCall extends Expr, TFunctionCall {
  HCL::FunctionCall functionCall;

  override string getAPrimaryQlClass() { result = "FunctionCall" }

  FunctionCall() { this = TFunctionCall(functionCall) }

  Expr getCallee() { toHclTreeSitter(result) = functionCall.getFunction() }

  Expr getArgument(int i) { toHclTreeSitter(result) = functionCall.getArgument(i) }

  override AstNode getAChild(string pred) {
    pred = "getCallee" and result = this.getCallee()
    or
    pred = "getArgument" and result = this.getArgument(_)
  }
}

class HereDoc extends Expr, THeredocTemplate {
  HCL::HeredocTemplate hereDoc;

  HereDoc() { this = THeredocTemplate(hereDoc) }
}

class Variable extends Expr, TVariable {
  HCL::VariableExpr var;

  Variable() { this = TVariable(var) }

  string getName() { result = var.getName().getValue() }
}

class GetAttrExpr extends Expr, TGetAttrExpr {
  HCL::GetAttrExpr getAttr;

  override string getAPrimaryQlClass() { result = "GetExpr" }

  GetAttrExpr() { this = TGetAttrExpr(getAttr) }

  Expr getExpr() { toHclTreeSitter(result) = getAttr.getExpr() }

  Identifier getKey() { toHclTreeSitter(result) = getAttr.getKey() }

  override string toString() { result = getExpr() + "." + getKey().getName() }

  override AstNode getAChild(string pred) {
    pred = "getExpr" and result = this.getExpr()
    or
    pred = "getKey" and result = this.getKey()
  }
}
