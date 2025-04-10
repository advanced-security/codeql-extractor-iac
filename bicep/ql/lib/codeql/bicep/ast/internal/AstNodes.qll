private import TreeSitter

/**
 * An AST node of a Bicep program
 */
cached
newtype TAstNode =
  TArguments(BICEP::Arguments r) or
  TArray(BICEP::Array r) or
  TArrayType(BICEP::ArrayType r) or
  TAssertStatement(BICEP::AssertStatement r) or
  TAssignmentExpression(BICEP::AssignmentExpression r) or
  TBinaryExpression(BICEP::BinaryExpression r) or
  TBoolean(BICEP::Boolean r) or
  TCallExpression(BICEP::CallExpression r) or
  TComment(BICEP::Comment r) or
  TCompatibleIdentifier(BICEP::CompatibleIdentifier r) or
  TDeclaration(BICEP::Declaration r) or
  TDecorator(BICEP::Decorator r) or
  TDecorators(BICEP::Decorators r) or
  TDiagnosticComment(BICEP::DiagnosticComment r) or
  TEscapeSequence(BICEP::EscapeSequence r) or
  TExpression(BICEP::Expression r) or
  TForLoopParameters(BICEP::ForLoopParameters r) or
  TForStatement(BICEP::ForStatement r) or
  TIdentifier(BICEP::Identifier r) or
  TIfStatement(BICEP::IfStatement r) or
  TImportFunctionality(BICEP::ImportFunctionality r) or
  TImportStatement(BICEP::ImportStatement r) or
  TImportWithStatement(BICEP::ImportWithStatement r) or
  TInfrastructure(BICEP::Infrastructure r) or
  TInterpolation(BICEP::Interpolation r) or
  TLambdaExpression(BICEP::LambdaExpression r) or
  TLoopEnumerator(BICEP::LoopEnumerator r) or
  TLoopVariable(BICEP::LoopVariable r) or
  TMemberExpression(BICEP::MemberExpression r) or
  TMetadataDeclaration(BICEP::MetadataDeclaration r) or
  TModuleDeclaration(BICEP::ModuleDeclaration r) or
  TNegatedType(BICEP::NegatedType r) or
  TNull(BICEP::Null r) or
  TNullableReturnType(BICEP::NullableReturnType r) or
  TNullableType(BICEP::NullableType r) or
  TNumber(BICEP::Number r) or
  TObject(BICEP::Object r) or
  TObjectProperty(BICEP::ObjectProperty r) or
  TOutputDeclaration(BICEP::OutputDeclaration r) or
  TParameter(BICEP::Parameter r) or
  TParameterDeclaration(BICEP::ParameterDeclaration r) or
  TParameterizedType(BICEP::ParameterizedType r) or
  TParameters(BICEP::Parameters r) or
  TParenthesizedExpression(BICEP::ParenthesizedExpression r) or
  TParenthesizedType(BICEP::ParenthesizedType r) or
  TPrimaryExpression(BICEP::PrimaryExpression r) or
  TPrimitiveType(BICEP::PrimitiveType r) or
  TPropertyIdentifier(BICEP::PropertyIdentifier r) or
  TResourceDeclaration(BICEP::ResourceDeclaration r) or
  TResourceExpression(BICEP::ResourceExpression r) or
  TStatement(BICEP::Statement r) or
  TString(BICEP::String r) or
  TStringContent(BICEP::StringContent r) or
  TSubscriptExpression(BICEP::SubscriptExpression r) or
  TTargetScopeAssignment(BICEP::TargetScopeAssignment r) or
  TTernaryExpression(BICEP::TernaryExpression r) or
  TTestBlock(BICEP::TestBlock r) or
  TType(BICEP::Type r) or
  TTypeArguments(BICEP::TypeArguments r) or
  TTypeDeclaration(BICEP::TypeDeclaration r) or
  TUnaryExpression(BICEP::UnaryExpression r) or
  TUnionType(BICEP::UnionType r) or
  TUserDefinedFunction(BICEP::UserDefinedFunction r) or
  TUsingStatement(BICEP::UsingStatement r) or
  TVariableDeclaration(BICEP::VariableDeclaration r)

/**
 * A literal value in a Bicep program
 */
class TLiterals =
  TInterpolation or TNull or TNullableReturnType or TNullableType or TString or TStringContent;

/**
 * A statement in a Bicep program
 */
class TStmts =
  TAssertStatement or TForStatement or TIfStatement or TImportStatement or TImportWithStatement or
      TStatement or TUsingStatement;

/**
 * A expersion value in a Bicep program
 */
class TExpr =
  TLiterals or TConditionalExpr or TAssignmentExpression or TBinaryExpression or TCallExpression or
      TExpression or TLambdaExpression or TMemberExpression or TParenthesizedExpression or
      TPrimaryExpression or TResourceExpression or TSubscriptExpression or TTernaryExpression or
      TUnaryExpression;

/**
 * A expersion value in a Bicep program
 */
class TConditionalExpr = TIfStatement;

cached
BICEP::AstNode toTreeSitter(TAstNode n) {
  n = TArguments(result) or
  n = TArray(result) or
  n = TArrayType(result) or
  n = TAssertStatement(result) or
  n = TAssignmentExpression(result) or
  n = TBinaryExpression(result) or
  n = TBoolean(result) or
  n = TCallExpression(result) or
  n = TComment(result) or
  n = TCompatibleIdentifier(result) or
  n = TDeclaration(result) or
  n = TDecorator(result) or
  n = TDecorators(result) or
  n = TDiagnosticComment(result) or
  n = TEscapeSequence(result) or
  n = TExpression(result) or
  n = TForLoopParameters(result) or
  n = TForStatement(result) or
  n = TIdentifier(result) or
  n = TIfStatement(result) or
  n = TImportFunctionality(result) or
  n = TImportStatement(result) or
  n = TImportWithStatement(result) or
  n = TInfrastructure(result) or
  n = TInterpolation(result) or
  n = TLambdaExpression(result) or
  n = TLoopEnumerator(result) or
  n = TLoopVariable(result) or
  n = TMemberExpression(result) or
  n = TMetadataDeclaration(result) or
  n = TModuleDeclaration(result) or
  n = TNegatedType(result) or
  n = TNull(result) or
  n = TNullableReturnType(result) or
  n = TNullableType(result) or
  n = TNumber(result) or
  n = TObject(result) or
  n = TObjectProperty(result) or
  n = TOutputDeclaration(result) or
  n = TParameter(result) or
  n = TParameterDeclaration(result) or
  n = TParameterizedType(result) or
  n = TParameters(result) or
  n = TParenthesizedExpression(result) or
  n = TParenthesizedType(result) or
  n = TPrimaryExpression(result) or
  n = TPrimitiveType(result) or
  n = TPropertyIdentifier(result) or
  n = TResourceDeclaration(result) or
  n = TResourceExpression(result) or
  n = TStatement(result) or
  n = TString(result) or
  n = TStringContent(result) or
  n = TSubscriptExpression(result) or
  n = TTargetScopeAssignment(result) or
  n = TTernaryExpression(result) or
  n = TTestBlock(result) or
  n = TType(result) or
  n = TTypeArguments(result) or
  n = TTypeDeclaration(result) or
  n = TUnaryExpression(result) or
  n = TUnionType(result) or
  n = TUserDefinedFunction(result) or
  n = TUsingStatement(result) or
  n = TVariableDeclaration(result)
}
