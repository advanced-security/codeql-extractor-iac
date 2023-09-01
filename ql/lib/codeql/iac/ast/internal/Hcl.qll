import TreeSitter

/**
 * HCL Ast Nodes
 */
cached
newtype THclAstNode =
  TAttribute(HCL::Attribute attribute) or
  TAttrSplat(HCL::AttrSplat attrSplat) or
  TBinaryOperation(HCL::BinaryOperation operation) or
  TBlock(HCL::Block block) or
  TBody(HCL::Body body) or
  TBooleanLiteral(HCL::BoolLit literal) or
  TComment(HCL::Comment comment) or
  TConditional(HCL::Conditional conditional) or
  TConfigFile(HCL::ConfigFile file) or
  TEllipsis(HCL::Ellipsis ellipsis) or
  TForExpr(HCL::ForExpr forExpr) or
  TForObjectExpr(HCL::ForObjectExpr forObjectExpr) or
  TForTupleExpr(HCL::ForTupleExpr forTupleExpr) or
  TFullSplat(HCL::FullSplat fullSplat) or
  TFunctionCall(HCL::FunctionCall call) or
  TGetAttr(HCL::GetAttr getAttr) or
  TGetAttrExpr(HCL::GetAttrExpr getAttr) or
  TIdentifier(HCL::Identifier identifier) or
  TIndex(HCL::Index index) or
  TNullLiteral(HCL::NullLit literal) or
  TNumericLit(HCL::NumericLit literal) or
  TObject(HCL::Object object) or
  TObjectElem(HCL::ObjectElem objectElem) or
  TQuotedTemplate(HCL::QuotedTemplate quotedTemplate) or
  TSplatExpr(HCL::SplatExpr splat) or
  TStringLit(HCL::StringLit literal) or
  TTemplateFor(HCL::TemplateFor templateFor) or
  TTemplateIf(HCL::TemplateIf templateIf) or
  TTemplateInterpolation(HCL::TemplateInterpolation templateInterpolation) or
  TTemplateLiteral(HCL::TemplateLiteral templateLiteral) or
  TTuple(HCL::Tuple tuple) or
  TUnaryOperation(HCL::UnaryOperation operation) or
  TVariable(HCL::VariableExpr variable) or
  THeredocTemplate(HCL::HeredocTemplate heredocTemplate)

class TTemplateDirective = TTemplateFor or TTemplateIf;

class TLiteral = TBooleanLiteral or TNumericLit or TStringLit or TNullLiteral;

class TExpr =
  TLiteral or TVariable or TFunctionCall or TUnaryOperation or TBinaryOperation or TConditional or
      TGetAttrExpr or TIndex or TTemplateLiteral or TTemplateInterpolation or TTemplateFor or
      TTemplateIf or TForExpr or TForObjectExpr or TForTupleExpr or TTuple or TObject or
      TAttrSplat or TFullSplat or TSplatExpr or TQuotedTemplate or TBlock or THeredocTemplate;

/**
 * Gets the underlying TreeSitter entity for a given AST node.
 */
cached
HCL::AstNode toHclTreeSitter(THclAstNode n) {
  n = TAttribute(result) or
  n = TAttrSplat(result) or
  n = TBinaryOperation(result) or
  n = TBlock(result) or
  n = TBody(result) or
  n = TBooleanLiteral(result) or
  n = TComment(result) or
  n = TConditional(result) or
  n = TConfigFile(result) or
  n = TEllipsis(result) or
  n = TForExpr(result) or
  n = TForObjectExpr(result) or
  n = TForTupleExpr(result) or
  n = TFullSplat(result) or
  n = TFunctionCall(result) or
  n = TGetAttrExpr(result) or
  n = TIdentifier(result) or
  n = TIndex(result) or
  n = TNullLiteral(result) or
  n = TNumericLit(result) or
  n = TObject(result) or
  n = TObjectElem(result) or
  n = TQuotedTemplate(result) or
  n = TSplatExpr(result) or
  n = TStringLit(result) or
  n = TTemplateFor(result) or
  n = TTemplateIf(result) or
  n = TTemplateInterpolation(result) or
  n = TTemplateLiteral(result) or
  n = TTuple(result) or
  n = TUnaryOperation(result) or
  n = TVariable(result) or
  n = THeredocTemplate(result)
}
