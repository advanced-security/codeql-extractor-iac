private import codeql.Locations
private import codeql.files.FileSystem
private import codeql.iac.ast.internal.Hcl
private import codeql.hcl.ast.AstNodes
private import codeql.hcl.ast.Attributes

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

  override HclAstNode getAChild(string pred) {
    pred = "getABlock" and result = this.getABlock()
    or
    pred = "getAttribute" and result = this.getAttribute(_)
  }

  Expr getAttribute(string name) {
    exists(Attribute attr | block.getBody().getChild(_) = toHclTreeSitter(attr) |
      attr.getKey().(Identifier).getName() = name and
      result = attr.getExpr()
    )
    or
    result = this.getABlock() and result.(Block).hasType(name)
  }

  Attribute getAttributes() { toHclTreeSitter(result) = block.getBody().getChild(_) }

  predicate hasAttribute(string name) {
    exists(Attribute attr | block.getBody().getChild(_) = toHclTreeSitter(attr) |
      attr.getKey().(Identifier).getName() = name
    )
  }

  Identifier getAttributeName(Expr expr) {
    exists(Attribute attr | attr = this.getAttributes() |
      attr.getExpr() = expr and
      result = attr.getKey()
    )
  }
}
