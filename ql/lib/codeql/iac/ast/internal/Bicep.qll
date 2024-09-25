import TreeSitter

cached
newtype TBicepAstNode =
  TComment(BICEP::Comment c) or
  TInfrastructure(BICEP::Infrastructure i) or
  // Literals
  TBoolean(BICEP::Boolean b) or
  TNull(BICEP::Null n) or
  TNumber(BICEP::Number n) or
  TString(BICEP::String s) or
  TStringContent(BICEP::StringContent s) or
  TMultilineStringContent(BICEP::MultilineStringContent m) or
  // Expressions
  TStatement(BICEP::Statement s) or
  TDecorator(BICEP::Decorator d) or
  TAssignmentExpression(BICEP::AssignmentExpression a) or
  TArray(BICEP::Array a) or
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
  TUnaryExpression(BICEP::UnaryExpression u) or
  TPropertyIdentifier(BICEP::PropertyIdentifier p) or
  TArguments(BICEP::Arguments a) or
  TDecorators(BICEP::Decorators d) or
  // Declarations
  TResourceDeclaration(BICEP::ResourceDeclaration r) or
  TObject(BICEP::Object o) or
  TObjectProperty(BICEP::ObjectProperty p) or
  TIdentifier(BICEP::Identifier i) or
  TParameterDeclaration(BICEP::ParameterDeclaration p) or
  // Loops
  TForExpression(BICEP::ForStatement l) or
  TLoopVariable(BICEP::LoopVariable l) or
  TLoopEnumerator(BICEP::LoopEnumerator l) or
  TForLoopParameters(BICEP::ForLoopParameters p) or
  TBuiltinType(BICEP::BuiltinType b) or
  TType(BICEP::Type t) or
  TPrimitiveType(BICEP::PrimitiveType p)

class TLiteral =
  TBoolean or TNull or TNumber or TString or TStringContent or TMultilineStringContent;

class TVariables = TLoopVariable;

class TDeclaration = TResourceDeclaration or TObject or TObjectProperty or TIdentifier;

class TIdentifiers = TIdentifier or TPropertyIdentifier;

class TLoops = TForExpression or TLoopEnumerator;

class TExpr =
  TLiteral or TVariables or TStatement or TArray or TAssignmentExpression or TBinaryExpression or
      TCallExpression or TExpression or TLambdaExpression or TMemberExpression or
      TParenthesizedExpression or TResourceExpression or TSubscriptExpression or
      TTernaryExpression or TUnaryExpression or TIdentifiers or TObject or TObjectProperty or
      TLoops or TDecorator;

cached
BICEP::AstNode toBicepTreeSitter(TBicepAstNode n) {
  n = TComment(result) or
  n = TInfrastructure(result) or
  n = TBoolean(result) or
  n = TNull(result) or
  n = TNumber(result) or
  n = TString(result) or
  n = TStringContent(result) or
  n = TMultilineStringContent(result) or
  n = TStatement(result) or
  n = TDecorator(result) or
  n = TAssignmentExpression(result) or
  n = TArguments(result) or
  n = TArray(result) or
  n = TBinaryExpression(result) or
  n = TCallExpression(result) or
  n = TExpression(result) or
  n = TLambdaExpression(result) or
  n = TMemberExpression(result) or
  n = TParenthesizedExpression(result) or
  n = TPrimaryExpression(result) or
  n = TResourceExpression(result) or
  n = TSubscriptExpression(result) or
  n = TTernaryExpression(result) or
  n = TUnaryExpression(result) or
  n = TResourceDeclaration(result) or
  n = TObject(result) or
  n = TObjectProperty(result) or
  n = TIdentifier(result) or
  n = TPropertyIdentifier(result) or
  n = TForExpression(result) or
  n = TLoopEnumerator(result) or
  n = TLoopVariable(result) or
  n = TForLoopParameters(result) or
  n = TBuiltinType(result) or
  n = TType(result) or
  n = TPrimitiveType(result) or
  n = TParameterDeclaration(result) or
  n = TDecorators(result)
}
