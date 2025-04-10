/**
 * CodeQL library for BICEP
 * Automatically generated from the tree-sitter grammar; do not edit
 */

import codeql.Locations as L

module BICEP {
  /** The base class for all AST nodes */
  class AstNode extends @bicep_ast_node {
    /** Gets a string representation of this element. */
    string toString() { result = this.getAPrimaryQlClass() }

    /** Gets the location of this element. */
    final L::Location getLocation() { bicep_ast_node_location(this, result) }

    /** Gets the parent of this element. */
    final AstNode getParent() { bicep_ast_node_parent(this, result, _) }

    /** Gets the index of this node among the children of its parent. */
    final int getParentIndex() { bicep_ast_node_parent(this, _, result) }

    /** Gets a field or child node of this node. */
    AstNode getAFieldOrChild() { none() }

    /** Gets the name of the primary QL class for this element. */
    string getAPrimaryQlClass() { result = "???" }

    /** Gets a comma-separated list of the names of the primary CodeQL classes to which this element belongs. */
    string getPrimaryQlClasses() { result = concat(this.getAPrimaryQlClass(), ",") }
  }

  /** A token. */
  class Token extends @bicep_token, AstNode {
    /** Gets the value of this token. */
    final string getValue() { bicep_tokeninfo(this, _, result) }

    /** Gets a string representation of this element. */
    final override string toString() { result = this.getValue() }

    /** Gets the name of the primary QL class for this element. */
    override string getAPrimaryQlClass() { result = "Token" }
  }

  /** A reserved word. */
  class ReservedWord extends @bicep_reserved_word, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ReservedWord" }
  }

  /** A class representing `arguments` nodes. */
  class Arguments extends @bicep_arguments, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Arguments" }

    /** Gets the `i`th child of this node. */
    final Expression getChild(int i) { bicep_arguments_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_arguments_child(this, _, result) }
  }

  /** A class representing `array` nodes. */
  class Array extends @bicep_array, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Array" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_array_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_array_child(this, _, result) }
  }

  /** A class representing `array_type` nodes. */
  class ArrayType extends @bicep_array_type, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ArrayType" }

    /** Gets the child of this node. */
    final Type getChild() { bicep_array_type_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_array_type_def(this, result) }
  }

  /** A class representing `assert_statement` nodes. */
  class AssertStatement extends @bicep_assert_statement, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "AssertStatement" }

    /** Gets the node corresponding to the field `name`. */
    final Identifier getName() { bicep_assert_statement_def(this, result, _) }

    /** Gets the child of this node. */
    final Expression getChild() { bicep_assert_statement_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_assert_statement_def(this, result, _) or bicep_assert_statement_def(this, _, result)
    }
  }

  /** A class representing `assignment_expression` nodes. */
  class AssignmentExpression extends @bicep_assignment_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "AssignmentExpression" }

    /** Gets the node corresponding to the field `left`. */
    final AstNode getLeft() { bicep_assignment_expression_def(this, result, _) }

    /** Gets the node corresponding to the field `right`. */
    final Expression getRight() { bicep_assignment_expression_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_assignment_expression_def(this, result, _) or
      bicep_assignment_expression_def(this, _, result)
    }
  }

  /** A class representing `binary_expression` nodes. */
  class BinaryExpression extends @bicep_binary_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "BinaryExpression" }

    /** Gets the node corresponding to the field `left`. */
    final Expression getLeft() { bicep_binary_expression_def(this, result, _, _) }

    /** Gets the node corresponding to the field `operator`. */
    final string getOperator() {
      exists(int value | bicep_binary_expression_def(this, _, value, _) |
        result = "!=" and value = 0
        or
        result = "!~" and value = 1
        or
        result = "%" and value = 2
        or
        result = "&&" and value = 3
        or
        result = "*" and value = 4
        or
        result = "+" and value = 5
        or
        result = "-" and value = 6
        or
        result = "/" and value = 7
        or
        result = "<" and value = 8
        or
        result = "<=" and value = 9
        or
        result = "==" and value = 10
        or
        result = "=~" and value = 11
        or
        result = ">" and value = 12
        or
        result = ">=" and value = 13
        or
        result = "??" and value = 14
        or
        result = "|" and value = 15
        or
        result = "||" and value = 16
      )
    }

    /** Gets the node corresponding to the field `right`. */
    final Expression getRight() { bicep_binary_expression_def(this, _, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_binary_expression_def(this, result, _, _) or
      bicep_binary_expression_def(this, _, _, result)
    }
  }

  /** A class representing `boolean` tokens. */
  class Boolean extends @bicep_token_boolean, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Boolean" }
  }

  /** A class representing `call_expression` nodes. */
  class CallExpression extends @bicep_call_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "CallExpression" }

    /** Gets the node corresponding to the field `arguments`. */
    final Arguments getArguments() { bicep_call_expression_def(this, result, _) }

    /** Gets the node corresponding to the field `function`. */
    final Expression getFunction() { bicep_call_expression_def(this, _, result) }

    /** Gets the child of this node. */
    final NullableReturnType getChild() { bicep_call_expression_child(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_call_expression_def(this, result, _) or
      bicep_call_expression_def(this, _, result) or
      bicep_call_expression_child(this, result)
    }
  }

  /** A class representing `comment` tokens. */
  class Comment extends @bicep_token_comment, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Comment" }
  }

  /** A class representing `compatible_identifier` nodes. */
  class CompatibleIdentifier extends @bicep_compatible_identifier, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "CompatibleIdentifier" }

    /** Gets the child of this node. */
    final Identifier getChild() { bicep_compatible_identifier_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_compatible_identifier_def(this, result) }
  }

  class Declaration extends @bicep_declaration, AstNode { }

  /** A class representing `decorator` nodes. */
  class Decorator extends @bicep_decorator, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Decorator" }

    /** Gets the child of this node. */
    final CallExpression getChild() { bicep_decorator_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_decorator_def(this, result) }
  }

  /** A class representing `decorators` nodes. */
  class Decorators extends @bicep_decorators, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Decorators" }

    /** Gets the `i`th child of this node. */
    final Decorator getChild(int i) { bicep_decorators_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_decorators_child(this, _, result) }
  }

  /** A class representing `diagnostic_comment` tokens. */
  class DiagnosticComment extends @bicep_token_diagnostic_comment, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "DiagnosticComment" }
  }

  /** A class representing `escape_sequence` tokens. */
  class EscapeSequence extends @bicep_token_escape_sequence, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "EscapeSequence" }
  }

  class Expression extends @bicep_expression, AstNode { }

  /** A class representing `for_loop_parameters` nodes. */
  class ForLoopParameters extends @bicep_for_loop_parameters, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ForLoopParameters" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_for_loop_parameters_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_for_loop_parameters_child(this, _, result) }
  }

  /** A class representing `for_statement` nodes. */
  class ForStatement extends @bicep_for_statement, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ForStatement" }

    /** Gets the node corresponding to the field `body`. */
    final AstNode getBody() { bicep_for_statement_def(this, result) }

    /** Gets the node corresponding to the field `initializer`. */
    final Identifier getInitializer() { bicep_for_statement_initializer(this, result) }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_for_statement_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_for_statement_def(this, result) or
      bicep_for_statement_initializer(this, result) or
      bicep_for_statement_child(this, _, result)
    }
  }

  /** A class representing `identifier` tokens. */
  class Identifier extends @bicep_token_identifier, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Identifier" }
  }

  /** A class representing `if_statement` nodes. */
  class IfStatement extends @bicep_if_statement, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "IfStatement" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_if_statement_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_if_statement_child(this, _, result) }
  }

  /** A class representing `import_functionality` nodes. */
  class ImportFunctionality extends @bicep_import_functionality, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImportFunctionality" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_import_functionality_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_import_functionality_child(this, _, result) }
  }

  /** A class representing `import_statement` nodes. */
  class ImportStatement extends @bicep_import_statement, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImportStatement" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_import_statement_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_import_statement_child(this, _, result) }
  }

  /** A class representing `import_with_statement` nodes. */
  class ImportWithStatement extends @bicep_import_with_statement, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImportWithStatement" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_import_with_statement_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_import_with_statement_child(this, _, result) }
  }

  /** A class representing `infrastructure` nodes. */
  class Infrastructure extends @bicep_infrastructure, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Infrastructure" }

    /** Gets the `i`th child of this node. */
    final Statement getChild(int i) { bicep_infrastructure_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_infrastructure_child(this, _, result) }
  }

  /** A class representing `interpolation` nodes. */
  class Interpolation extends @bicep_interpolation, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Interpolation" }

    /** Gets the child of this node. */
    final Expression getChild() { bicep_interpolation_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_interpolation_def(this, result) }
  }

  /** A class representing `lambda_expression` nodes. */
  class LambdaExpression extends @bicep_lambda_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "LambdaExpression" }

    /** Gets the `i`th child of this node. */
    final Expression getChild(int i) { bicep_lambda_expression_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_lambda_expression_child(this, _, result) }
  }

  /** A class representing `loop_enumerator` tokens. */
  class LoopEnumerator extends @bicep_token_loop_enumerator, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "LoopEnumerator" }
  }

  /** A class representing `loop_variable` tokens. */
  class LoopVariable extends @bicep_token_loop_variable, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "LoopVariable" }
  }

  /** A class representing `member_expression` nodes. */
  class MemberExpression extends @bicep_member_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "MemberExpression" }

    /** Gets the node corresponding to the field `object`. */
    final AstNode getObject() { bicep_member_expression_def(this, result, _) }

    /** Gets the node corresponding to the field `property`. */
    final PropertyIdentifier getProperty() { bicep_member_expression_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_member_expression_def(this, result, _) or bicep_member_expression_def(this, _, result)
    }
  }

  /** A class representing `metadata_declaration` nodes. */
  class MetadataDeclaration extends @bicep_metadata_declaration, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "MetadataDeclaration" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_metadata_declaration_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_metadata_declaration_child(this, _, result) }
  }

  /** A class representing `module_declaration` nodes. */
  class ModuleDeclaration extends @bicep_module_declaration, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ModuleDeclaration" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_module_declaration_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_module_declaration_child(this, _, result) }
  }

  /** A class representing `negated_type` nodes. */
  class NegatedType extends @bicep_negated_type, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "NegatedType" }

    /** Gets the child of this node. */
    final Type getChild() { bicep_negated_type_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_negated_type_def(this, result) }
  }

  /** A class representing `null` tokens. */
  class Null extends @bicep_token_null, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Null" }
  }

  /** A class representing `nullable_return_type` tokens. */
  class NullableReturnType extends @bicep_token_nullable_return_type, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "NullableReturnType" }
  }

  /** A class representing `nullable_type` nodes. */
  class NullableType extends @bicep_nullable_type, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "NullableType" }

    /** Gets the child of this node. */
    final AstNode getChild() { bicep_nullable_type_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_nullable_type_def(this, result) }
  }

  /** A class representing `number` tokens. */
  class Number extends @bicep_token_number, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Number" }
  }

  /** A class representing `object` nodes. */
  class Object extends @bicep_object, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Object" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_object_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_object_child(this, _, result) }
  }

  /** A class representing `object_property` nodes. */
  class ObjectProperty extends @bicep_object_property, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ObjectProperty" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_object_property_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_object_property_child(this, _, result) }
  }

  /** A class representing `output_declaration` nodes. */
  class OutputDeclaration extends @bicep_output_declaration, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "OutputDeclaration" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_output_declaration_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_output_declaration_child(this, _, result) }
  }

  /** A class representing `parameter` nodes. */
  class Parameter extends @bicep_parameter, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Parameter" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_parameter_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_parameter_child(this, _, result) }
  }

  /** A class representing `parameter_declaration` nodes. */
  class ParameterDeclaration extends @bicep_parameter_declaration, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ParameterDeclaration" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_parameter_declaration_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_parameter_declaration_child(this, _, result) }
  }

  /** A class representing `parameterized_type` nodes. */
  class ParameterizedType extends @bicep_parameterized_type, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ParameterizedType" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_parameterized_type_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_parameterized_type_child(this, _, result) }
  }

  /** A class representing `parameters` nodes. */
  class Parameters extends @bicep_parameters, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Parameters" }

    /** Gets the `i`th child of this node. */
    final Parameter getChild(int i) { bicep_parameters_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_parameters_child(this, _, result) }
  }

  /** A class representing `parenthesized_expression` nodes. */
  class ParenthesizedExpression extends @bicep_parenthesized_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ParenthesizedExpression" }

    /** Gets the `i`th child of this node. */
    final Expression getChild(int i) { bicep_parenthesized_expression_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_parenthesized_expression_child(this, _, result)
    }
  }

  /** A class representing `parenthesized_type` nodes. */
  class ParenthesizedType extends @bicep_parenthesized_type, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ParenthesizedType" }

    /** Gets the child of this node. */
    final Type getChild() { bicep_parenthesized_type_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_parenthesized_type_def(this, result) }
  }

  class PrimaryExpression extends @bicep_primary_expression, AstNode { }

  /** A class representing `primitive_type` tokens. */
  class PrimitiveType extends @bicep_token_primitive_type, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "PrimitiveType" }
  }

  /** A class representing `property_identifier` tokens. */
  class PropertyIdentifier extends @bicep_token_property_identifier, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "PropertyIdentifier" }
  }

  /** A class representing `resource_declaration` nodes. */
  class ResourceDeclaration extends @bicep_resource_declaration, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ResourceDeclaration" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_resource_declaration_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_resource_declaration_child(this, _, result) }
  }

  /** A class representing `resource_expression` nodes. */
  class ResourceExpression extends @bicep_resource_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ResourceExpression" }

    /** Gets the node corresponding to the field `object`. */
    final Expression getObject() { bicep_resource_expression_def(this, result, _) }

    /** Gets the node corresponding to the field `resource`. */
    final Identifier getResource() { bicep_resource_expression_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_resource_expression_def(this, result, _) or
      bicep_resource_expression_def(this, _, result)
    }
  }

  class Statement extends @bicep_statement, AstNode { }

  /** A class representing `string` nodes. */
  class String extends @bicep_string__, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "String" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_string_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_string_child(this, _, result) }
  }

  /** A class representing `string_content` tokens. */
  class StringContent extends @bicep_token_string_content, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "StringContent" }
  }

  /** A class representing `subscript_expression` nodes. */
  class SubscriptExpression extends @bicep_subscript_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "SubscriptExpression" }

    /** Gets the node corresponding to the field `index`. */
    final Expression getIndex() { bicep_subscript_expression_def(this, result, _) }

    /** Gets the node corresponding to the field `object`. */
    final Expression getObject() { bicep_subscript_expression_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_subscript_expression_def(this, result, _) or
      bicep_subscript_expression_def(this, _, result)
    }
  }

  /** A class representing `target_scope_assignment` nodes. */
  class TargetScopeAssignment extends @bicep_target_scope_assignment, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TargetScopeAssignment" }

    /** Gets the child of this node. */
    final String getChild() { bicep_target_scope_assignment_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_target_scope_assignment_def(this, result) }
  }

  /** A class representing `ternary_expression` nodes. */
  class TernaryExpression extends @bicep_ternary_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TernaryExpression" }

    /** Gets the node corresponding to the field `alternative`. */
    final Expression getAlternative() { bicep_ternary_expression_def(this, result, _, _) }

    /** Gets the node corresponding to the field `condition`. */
    final Expression getCondition() { bicep_ternary_expression_def(this, _, result, _) }

    /** Gets the node corresponding to the field `consequence`. */
    final Expression getConsequence() { bicep_ternary_expression_def(this, _, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_ternary_expression_def(this, result, _, _) or
      bicep_ternary_expression_def(this, _, result, _) or
      bicep_ternary_expression_def(this, _, _, result)
    }
  }

  /** A class representing `test_block` nodes. */
  class TestBlock extends @bicep_test_block, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TestBlock" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_test_block_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_test_block_child(this, _, result) }
  }

  /** A class representing `type` nodes. */
  class Type extends @bicep_type__, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Type" }

    /** Gets the child of this node. */
    final AstNode getChild() { bicep_type_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_type_def(this, result) }
  }

  /** A class representing `type_arguments` nodes. */
  class TypeArguments extends @bicep_type_arguments, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TypeArguments" }

    /** Gets the `i`th child of this node. */
    final String getChild(int i) { bicep_type_arguments_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_type_arguments_child(this, _, result) }
  }

  /** A class representing `type_declaration` nodes. */
  class TypeDeclaration extends @bicep_type_declaration, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TypeDeclaration" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_type_declaration_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_type_declaration_child(this, _, result) }
  }

  /** A class representing `unary_expression` nodes. */
  class UnaryExpression extends @bicep_unary_expression, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UnaryExpression" }

    /** Gets the node corresponding to the field `argument`. */
    final Expression getArgument() { bicep_unary_expression_def(this, result, _) }

    /** Gets the node corresponding to the field `operator`. */
    final string getOperator() {
      exists(int value | bicep_unary_expression_def(this, _, value) |
        result = "!" and value = 0
        or
        result = "-" and value = 1
      )
    }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_unary_expression_def(this, result, _) }
  }

  /** A class representing `union_type` nodes. */
  class UnionType extends @bicep_union_type, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UnionType" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_union_type_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_union_type_child(this, _, result) }
  }

  /** A class representing `user_defined_function` nodes. */
  class UserDefinedFunction extends @bicep_user_defined_function, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UserDefinedFunction" }

    /** Gets the node corresponding to the field `name`. */
    final Identifier getName() { bicep_user_defined_function_def(this, result, _) }

    /** Gets the node corresponding to the field `returns`. */
    final Type getReturns() { bicep_user_defined_function_def(this, _, result) }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_user_defined_function_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      bicep_user_defined_function_def(this, result, _) or
      bicep_user_defined_function_def(this, _, result) or
      bicep_user_defined_function_child(this, _, result)
    }
  }

  /** A class representing `using_statement` nodes. */
  class UsingStatement extends @bicep_using_statement, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UsingStatement" }

    /** Gets the child of this node. */
    final String getChild() { bicep_using_statement_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_using_statement_def(this, result) }
  }

  /** A class representing `variable_declaration` nodes. */
  class VariableDeclaration extends @bicep_variable_declaration, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "VariableDeclaration" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { bicep_variable_declaration_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { bicep_variable_declaration_child(this, _, result) }
  }
}
