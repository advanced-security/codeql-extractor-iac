import TreeSitter

cached
newtype TBicepAstNode =
  TComment(BICEP::Comment c) or
  // Literals
  TBoolean(BICEP::Boolean b) or
  TNull(BICEP::Null n) or
  TNumber(BICEP::Number n) or
  TString(BICEP::String s) or
  TMultilineStringContent(BICEP::MultilineStringContent m) or
  // Expressions
  TAssignmentExpression(BICEP::AssignmentExpression a) or
  TBinaryExpression(BICEP::BinaryExpression b) or
  TCallExpression(BICEP::CallExpression c) or
  TExpression(BICEP::Expression e) or
  TLambdaExpression(BICEP::LambdaExpression l) or
  TMemberExpression(BICEP::MemberExpression m) or
  TParenthesizedExpression(BICEP::ParenthesizedExpression p) or
  TPrimaryExpression(BICEP::PrimaryExpression p) or
  TResourceExpression(BICEP::ResourceExpression r) or
  TSubscriptExpression(BICEP::SubscriptExpression s) or
  TTernaryExpression(BICEP::TernaryExpression t) or
  TUnaryExpression(BICEP::UnaryExpression u)

class TLiteral = TBoolean or TNull or TNumber or TString or TMultilineStringContent;

class TExpr =
  TAssignmentExpression or TBinaryExpression or TCallExpression or TExpression or
      TLambdaExpression or TMemberExpression or TParenthesizedExpression or TPrimaryExpression or
      TResourceExpression or TSubscriptExpression or TTernaryExpression or TUnaryExpression;

cached
BICEP::AstNode toBicepTreeSitter(TBicepAstNode n) {
  n = TComment(result) or
  n = TBoolean(result) or
  n = TNull(result)
}
