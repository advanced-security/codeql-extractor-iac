import TreeSitter

/**
 * JSON Ast Nodes
 */
cached
newtype TJsonAstNode =
  TReservedWord(JSON::ReservedWord node) or
  TComment(JSON::Comment node) or
  TArray(JSON::Array node) or
  TDocument(JSON::Document node) or
  TFalse(JSON::False node) or
  TTrue(JSON::True node) or
  TNull(JSON::Null node) or
  TNumber(JSON::Number node) or
  TObject(JSON::Object node) or
  TPair(JSON::Pair node) or
  TString(JSON::String node) or
  TStringContent(JSON::StringContent node) or
  TValue(JSON::Value node)

class TBooleanLiteral = TFalse or TTrue;

class TLiteral = TBooleanLiteral or TNumber or TString or TNull;

/**
 * Gets the underlying TreeSitter entity for a given AST node.
 */
cached
JSON::AstNode toJsonTreeSitter(TJsonAstNode n) {
  //   n = TAttribute(result) or
  n = TReservedWord(result) or
  n = TComment(result) or
  n = TArray(result) or
  n = TDocument(result) or
  n = TFalse(result) or
  n = TTrue(result) or
  n = TNull(result) or
  n = TNumber(result) or
  n = TObject(result) or
  n = TPair(result) or
  n = TString(result) or
  n = TStringContent(result) or
  n = TValue(result)
}
