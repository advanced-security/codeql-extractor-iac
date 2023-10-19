private import codeql.Locations
private import codeql.files.FileSystem
private import codeql.iac.ast.internal.Bicep
private import codeql.bicep.ast.internal.AstNodes
private import codeql.bicep.ast.internal.Resources
private import codeql.bicep.ast.internal.Object
private import codeql.bicep.ast.internal.Literal
private import codeql.bicep.ast.internal.Expr

/**
 * A Bicep program.
 */
class InfrastructureImpl extends BicepAstNode, TInfrastructure {
  private BICEP::Infrastructure infrastructure;

  override string getAPrimaryQlClass() { result = "Infrastructure" }

  override string toString() { result = "Infrastructure" }

  InfrastructureImpl() { this = TInfrastructure(infrastructure) }

  StatementImpl getStatement(int i) { toBicepTreeSitter(result) = infrastructure.getChild(i) }

  StatementImpl getStatements() { toBicepTreeSitter(result) = infrastructure.getChild(_) }
}

ResourceImpl resolveResource(ExprImpl expr) {
  exists(ResourceImpl resource |
    // Object having an id property needs to be resolved
    // {resource.id}.id
    exists(MemberExprImpl memexpr |
      memexpr = expr.(ObjectImpl).getProperty("id") and
      memexpr.getObject().(IdentifierImpl).getName() =
        resource.getIdentifier().(IdentifierImpl).getName()
    |
      result = resource
    )
    or
    exists(IdentifierImpl ident |
      ident = expr and
      ident.getName() = resource.getIdentifier().(IdentifierImpl).getName()
    |
      result = resource
    )
  )
}

class ResourceImpl extends BicepAstNode, TResourceDeclaration {
  private BICEP::ResourceDeclaration resource;

  override string getAPrimaryQlClass() { result = "ResourceDeclaration" }

  ResourceImpl() { this = TResourceDeclaration(resource) }

  string getResourceType() {
    exists(StringLiteralImpl s | toBicepTreeSitter(s) = resource.getAFieldOrChild() |
      result = s.getValue()
    )
  }

  /**
   * A name given to the resource instance that is unique within the template.
   */
  IdentifierImpl getIdentifier() { toBicepTreeSitter(result) = resource.getChild(0) }

  ObjectImpl getBody() { toBicepTreeSitter(result) = resource.getAFieldOrChild() }

  ExprImpl getProperty(string name) { result = this.getBody().getProperty(name) }

  override ResourceImpl getParent() { result = resolveResource(this.getProperty("parent")) }
}

/**
 * A Bicep statement.
 */
class StatementImpl extends ExprImpl, TStatement {
  private BICEP::Statement statement;

  override string getAPrimaryQlClass() { result = "Statement" }

  StatementImpl() { this = TStatement(statement) }
}

class TypeImpl extends LiteralImpl, TType {
  private BICEP::Type type;

  override string getAPrimaryQlClass() { result = "Type" }

  override string toString() { result = "Type: " + this.getType() }

  TypeImpl() { this = TType(type) }

  string getType() { result = this.getBuiltinType().getType() }

  BuiltinTypeImpl getBuiltinType() { toBicepTreeSitter(result) = type.getAFieldOrChild() }
}

class BuiltinTypeImpl extends LiteralImpl, TBuiltinType {
  private BICEP::BuiltinType builtinType;

  override string getAPrimaryQlClass() { result = "BuiltinType" }

  override string toString() { result = "BuiltinType: " + this.getType() }

  BuiltinTypeImpl() { this = TBuiltinType(builtinType) }

  string getType() { result = this.getPrimitiveType().getValue() }

  PrimitiveTypeImpl getPrimitiveType() {
    toBicepTreeSitter(result) = builtinType.getAFieldOrChild()
  }
}

class PrimitiveTypeImpl extends LiteralImpl, TPrimitiveType {
  private BICEP::PrimitiveType primitiveType;

  override string getAPrimaryQlClass() { result = "PrimitiveType" }

  override string toString() { result = "PrimitiveType: " + this.getValue() }

  PrimitiveTypeImpl() { this = TPrimitiveType(primitiveType) }

  override string getValue() { result = primitiveType.getValue() }
}

class ParameterDeclarationImpl extends ExprImpl, TParameterDeclaration {
  private BICEP::ParameterDeclaration parameter;

  override string getAPrimaryQlClass() { result = "ParameterDeclaration" }

  ParameterDeclarationImpl() { this = TParameterDeclaration(parameter) }

  IdentifierImpl getName() { toBicepTreeSitter(result) = parameter.getChild(0) }

  ExprImpl getDefaultValue() { toBicepTreeSitter(result) = parameter.getChild(1) }
}

/**
 * A Bicep comment
 */
class CommentImpl extends BicepAstNode, TComment {
  override string getAPrimaryQlClass() { result = "Comment" }

  CommentImpl() { this = TComment(_) }
}
