import TreeSitter

/**
 * JSON Ast Nodes
 */
cached
newtype TJsonAstNode =
  TJsonReservedWord(JSON::ReservedWord node) or
  TJsonComment(JSON::Comment node) or
  TJsonArray(JSON::Array node) or
  TJsonDocument(JSON::Document node) or
  TJsonFalse(JSON::False node) or
  TJsonTrue(JSON::True node) or
  TJsonNull(JSON::Null node) or
  TJsonNumber(JSON::Number node) or
  TJsonObject(JSON::Object node) or
  TJsonPair(JSON::Pair node) or
  TJsonString(JSON::String node) or
  TJsonStringContent(JSON::StringContent node) or
  TJsonValue(JSON::Value node)

class TJsonBooleanLiteral = TJsonFalse or TJsonTrue;

class TJsonLiteral = TJsonBooleanLiteral or TJsonNumber or TJsonString or TJsonNull;

/**
 * Gets TJsonhe underlying TJsonreeSitter entity for a given AST node.
 */
cached
JSON::AstNode toJsonTreeSitter(TJsonAstNode n) {
  //   n = TJsonAttribute(result) or
  n = TJsonReservedWord(result) or
  n = TJsonComment(result) or
  n = TJsonArray(result) or
  n = TJsonDocument(result) or
  n = TJsonFalse(result) or
  n = TJsonTrue(result) or
  n = TJsonNull(result) or
  n = TJsonNumber(result) or
  n = TJsonObject(result) or
  n = TJsonPair(result) or
  n = TJsonString(result) or
  n = TJsonStringContent(result) or
  n = TJsonValue(result)
}
