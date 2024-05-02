/**
 * CodeQL library for HCL
 * Automatically generated from the tree-sitter grammar; do not edit
 */

import codeql.Locations as L

module HCL {
  /** The base class for all AST nodes */
  class AstNode extends @hcl_ast_node {
    /** Gets a string representation of this element. */
    string toString() { result = this.getAPrimaryQlClass() }

    /** Gets the location of this element. */
    final L::Location getLocation() { hcl_ast_node_info(this, _, _, result) }

    /** Gets the parent of this element. */
    final AstNode getParent() { hcl_ast_node_info(this, result, _, _) }

    /** Gets the index of this node among the children of its parent. */
    final int getParentIndex() { hcl_ast_node_info(this, _, result, _) }

    /** Gets a field or child node of this node. */
    AstNode getAFieldOrChild() { none() }

    /** Gets the name of the primary QL class for this element. */
    string getAPrimaryQlClass() { result = "???" }

    /** Gets a comma-separated list of the names of the primary CodeQL classes to which this element belongs. */
    string getPrimaryQlClasses() { result = concat(this.getAPrimaryQlClass(), ",") }
  }

  /** A token. */
  class Token extends @hcl_token, AstNode {
    /** Gets the value of this token. */
    final string getValue() { hcl_tokeninfo(this, _, result) }

    /** Gets a string representation of this element. */
    final override string toString() { result = this.getValue() }

    /** Gets the name of the primary QL class for this element. */
    override string getAPrimaryQlClass() { result = "Token" }
  }

  /** A reserved word. */
  class ReservedWord extends @hcl_reserved_word, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ReservedWord" }
  }

  class UnderscoreCollectionValue extends @hcl_underscore_collection_value, AstNode { }

  class UnderscoreExprTerm extends @hcl_underscore_expr_term, AstNode { }

  class UnderscoreExpression extends @hcl_underscore_expression, AstNode { }

  class UnderscoreLiteralValue extends @hcl_underscore_literal_value, AstNode { }

  class UnderscoreOperation extends @hcl_underscore_operation, AstNode { }

  class UnderscoreSplat extends @hcl_underscore_splat, AstNode { }

  class UnderscoreTemplateDirective extends @hcl_underscore_template_directive, AstNode { }

  class UnderscoreTemplateExpr extends @hcl_underscore_template_expr, AstNode { }

  /** A class representing `attr_splat` nodes. */
  class AttrSplat extends @hcl_attr_splat, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "AttrSplat" }

    /** Gets the node corresponding to the field `element`. */
    final GetAttr getElement(int i) { hcl_attr_splat_element(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_attr_splat_element(this, _, result) }
  }

  /** A class representing `attribute` nodes. */
  class Attribute extends @hcl_attribute, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Attribute" }

    /** Gets the node corresponding to the field `key`. */
    final Identifier getKey() { hcl_attribute_def(this, result, _) }

    /** Gets the node corresponding to the field `val`. */
    final UnderscoreExpression getVal() { hcl_attribute_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_attribute_def(this, result, _) or hcl_attribute_def(this, _, result)
    }
  }

  /** A class representing `binary_operation` nodes. */
  class BinaryOperation extends @hcl_binary_operation, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "BinaryOperation" }

    /** Gets the node corresponding to the field `left`. */
    final UnderscoreExprTerm getLeft() { hcl_binary_operation_def(this, result, _, _) }

    /** Gets the node corresponding to the field `operator`. */
    final string getOperator() {
      exists(int value | hcl_binary_operation_def(this, _, value, _) |
        result = "!=" and value = 0
        or
        result = "%" and value = 1
        or
        result = "&&" and value = 2
        or
        result = "*" and value = 3
        or
        result = "+" and value = 4
        or
        result = "-" and value = 5
        or
        result = "/" and value = 6
        or
        result = "<" and value = 7
        or
        result = "<=" and value = 8
        or
        result = "==" and value = 9
        or
        result = ">" and value = 10
        or
        result = ">=" and value = 11
        or
        result = "||" and value = 12
      )
    }

    /** Gets the node corresponding to the field `right`. */
    final UnderscoreExprTerm getRight() { hcl_binary_operation_def(this, _, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_binary_operation_def(this, result, _, _) or hcl_binary_operation_def(this, _, _, result)
    }
  }

  /** A class representing `block` nodes. */
  class Block extends @hcl_block, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Block" }

    /** Gets the node corresponding to the field `body`. */
    final Body getBody() { hcl_block_body(this, result) }

    /** Gets the node corresponding to the field `label`. */
    final AstNode getLabel(int i) { hcl_block_label(this, i, result) }

    /** Gets the node corresponding to the field `type`. */
    final Identifier getType() { hcl_block_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_block_body(this, result) or
      hcl_block_label(this, _, result) or
      hcl_block_def(this, result)
    }
  }

  /** A class representing `body` nodes. */
  class Body extends @hcl_body, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Body" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { hcl_body_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_body_child(this, _, result) }
  }

  /** A class representing `bool_lit` tokens. */
  class BoolLit extends @hcl_token_bool_lit, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "BoolLit" }
  }

  /** A class representing `comment` tokens. */
  class Comment extends @hcl_token_comment, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Comment" }
  }

  /** A class representing `conditional` nodes. */
  class Conditional extends @hcl_conditional, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Conditional" }

    /** Gets the node corresponding to the field `alternative`. */
    final UnderscoreExpression getAlternative() { hcl_conditional_def(this, result, _, _) }

    /** Gets the node corresponding to the field `body`. */
    final UnderscoreExpression getBody() { hcl_conditional_def(this, _, result, _) }

    /** Gets the node corresponding to the field `condition`. */
    final UnderscoreExpression getCondition() { hcl_conditional_def(this, _, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_conditional_def(this, result, _, _) or
      hcl_conditional_def(this, _, result, _) or
      hcl_conditional_def(this, _, _, result)
    }
  }

  /** A class representing `config_file` nodes. */
  class ConfigFile extends @hcl_config_file, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ConfigFile" }

    /** Gets the child of this node. */
    final AstNode getChild() { hcl_config_file_child(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_config_file_child(this, result) }
  }

  /** A class representing `ellipsis` tokens. */
  class Ellipsis extends @hcl_token_ellipsis, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Ellipsis" }
  }

  /** A class representing `for_expr` nodes. */
  class ForExpr extends @hcl_for_expr, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ForExpr" }

    /** Gets the child of this node. */
    final AstNode getChild() { hcl_for_expr_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_for_expr_def(this, result) }
  }

  /** A class representing `for_object_expr` nodes. */
  class ForObjectExpr extends @hcl_for_object_expr, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ForObjectExpr" }

    /** Gets the node corresponding to the field `condition`. */
    final UnderscoreExpression getCondition() { hcl_for_object_expr_condition(this, result) }

    /** Gets the node corresponding to the field `iter`. */
    final UnderscoreExpression getIter() { hcl_for_object_expr_def(this, result, _, _) }

    /** Gets the node corresponding to the field `key`. */
    final UnderscoreExpression getKey() { hcl_for_object_expr_def(this, _, result, _) }

    /** Gets the node corresponding to the field `target`. */
    final Identifier getTarget(int i) { hcl_for_object_expr_target(this, i, result) }

    /** Gets the node corresponding to the field `val`. */
    final UnderscoreExpression getVal() { hcl_for_object_expr_def(this, _, _, result) }

    /** Gets the child of this node. */
    final Ellipsis getChild() { hcl_for_object_expr_child(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_for_object_expr_condition(this, result) or
      hcl_for_object_expr_def(this, result, _, _) or
      hcl_for_object_expr_def(this, _, result, _) or
      hcl_for_object_expr_target(this, _, result) or
      hcl_for_object_expr_def(this, _, _, result) or
      hcl_for_object_expr_child(this, result)
    }
  }

  /** A class representing `for_tuple_expr` nodes. */
  class ForTupleExpr extends @hcl_for_tuple_expr, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ForTupleExpr" }

    /** Gets the node corresponding to the field `condition`. */
    final UnderscoreExpression getCondition() { hcl_for_tuple_expr_condition(this, result) }

    /** Gets the node corresponding to the field `expr`. */
    final UnderscoreExpression getExpr() { hcl_for_tuple_expr_def(this, result, _) }

    /** Gets the node corresponding to the field `iter`. */
    final UnderscoreExpression getIter() { hcl_for_tuple_expr_def(this, _, result) }

    /** Gets the node corresponding to the field `target`. */
    final Identifier getTarget(int i) { hcl_for_tuple_expr_target(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_for_tuple_expr_condition(this, result) or
      hcl_for_tuple_expr_def(this, result, _) or
      hcl_for_tuple_expr_def(this, _, result) or
      hcl_for_tuple_expr_target(this, _, result)
    }
  }

  /** A class representing `full_splat` nodes. */
  class FullSplat extends @hcl_full_splat, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "FullSplat" }

    /** Gets the node corresponding to the field `element`. */
    final AstNode getElement(int i) { hcl_full_splat_element(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_full_splat_element(this, _, result) }
  }

  /** A class representing `function_call` nodes. */
  class FunctionCall extends @hcl_function_call, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "FunctionCall" }

    /** Gets the node corresponding to the field `argument`. */
    final UnderscoreExpression getArgument(int i) { hcl_function_call_argument(this, i, result) }

    /** Gets the node corresponding to the field `function`. */
    final Identifier getFunction() { hcl_function_call_def(this, result) }

    /** Gets the child of this node. */
    final Ellipsis getChild() { hcl_function_call_child(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_function_call_argument(this, _, result) or
      hcl_function_call_def(this, result) or
      hcl_function_call_child(this, result)
    }
  }

  /** A class representing `get_attr` nodes. */
  class GetAttr extends @hcl_get_attr, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "GetAttr" }

    /** Gets the node corresponding to the field `key`. */
    final Identifier getKey() { hcl_get_attr_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_get_attr_def(this, result) }
  }

  /** A class representing `get_attr_expr` nodes. */
  class GetAttrExpr extends @hcl_get_attr_expr, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "GetAttrExpr" }

    /** Gets the node corresponding to the field `expr`. */
    final UnderscoreExprTerm getExpr() { hcl_get_attr_expr_def(this, result, _) }

    /** Gets the node corresponding to the field `key`. */
    final Identifier getKey() { hcl_get_attr_expr_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_get_attr_expr_def(this, result, _) or hcl_get_attr_expr_def(this, _, result)
    }
  }

  /** A class representing `heredoc_template` nodes. */
  class HeredocTemplate extends @hcl_heredoc_template, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HeredocTemplate" }

    /** Gets the node corresponding to the field `start`. */
    final string getStart() {
      exists(int value | hcl_heredoc_template_def(this, value) |
        result = "<<" and value = 0
        or
        result = "<<-" and value = 1
      )
    }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { hcl_heredoc_template_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_heredoc_template_child(this, _, result) }
  }

  /** A class representing `identifier` tokens. */
  class Identifier extends @hcl_token_identifier, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Identifier" }
  }

  /** A class representing `index` nodes. */
  class Index extends @hcl_index, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Index" }

    /** Gets the node corresponding to the field `index`. */
    final AstNode getIndex() { hcl_index_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_index_def(this, result) }
  }

  /** A class representing `index_expr` nodes. */
  class IndexExpr extends @hcl_index_expr, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "IndexExpr" }

    /** Gets the node corresponding to the field `expr`. */
    final UnderscoreExprTerm getExpr() { hcl_index_expr_def(this, result, _) }

    /** Gets the node corresponding to the field `index`. */
    final AstNode getIndex() { hcl_index_expr_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_index_expr_def(this, result, _) or hcl_index_expr_def(this, _, result)
    }
  }

  /** A class representing `null_lit` tokens. */
  class NullLit extends @hcl_token_null_lit, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "NullLit" }
  }

  /** A class representing `numeric_lit` tokens. */
  class NumericLit extends @hcl_token_numeric_lit, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "NumericLit" }
  }

  /** A class representing `object` nodes. */
  class Object extends @hcl_object, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Object" }

    /** Gets the node corresponding to the field `element`. */
    final ObjectElem getElement(int i) { hcl_object_element(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_object_element(this, _, result) }
  }

  /** A class representing `object_elem` nodes. */
  class ObjectElem extends @hcl_object_elem, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ObjectElem" }

    /** Gets the node corresponding to the field `key`. */
    final UnderscoreExpression getKey() { hcl_object_elem_def(this, result, _) }

    /** Gets the node corresponding to the field `val`. */
    final UnderscoreExpression getVal() { hcl_object_elem_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_object_elem_def(this, result, _) or hcl_object_elem_def(this, _, result)
    }
  }

  /** A class representing `parenthesized_expr` nodes. */
  class ParenthesizedExpr extends @hcl_parenthesized_expr, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ParenthesizedExpr" }

    /** Gets the child of this node. */
    final UnderscoreExpression getChild() { hcl_parenthesized_expr_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_parenthesized_expr_def(this, result) }
  }

  /** A class representing `quoted_template` nodes. */
  class QuotedTemplate extends @hcl_quoted_template, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "QuotedTemplate" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { hcl_quoted_template_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_quoted_template_child(this, _, result) }
  }

  /** A class representing `splat_expr` nodes. */
  class SplatExpr extends @hcl_splat_expr, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "SplatExpr" }

    /** Gets the node corresponding to the field `expr`. */
    final UnderscoreExprTerm getExpr() { hcl_splat_expr_def(this, result, _) }

    /** Gets the node corresponding to the field `splat`. */
    final UnderscoreSplat getSplat() { hcl_splat_expr_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_splat_expr_def(this, result, _) or hcl_splat_expr_def(this, _, result)
    }
  }

  /** A class representing `string_lit` nodes. */
  class StringLit extends @hcl_string_lit, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "StringLit" }

    /** Gets the child of this node. */
    final TemplateLiteral getChild() { hcl_string_lit_child(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_string_lit_child(this, result) }
  }

  /** A class representing `template_for` nodes. */
  class TemplateFor extends @hcl_template_for, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TemplateFor" }

    /** Gets the node corresponding to the field `body`. */
    final AstNode getBody(int i) { hcl_template_for_body(this, i, result) }

    /** Gets the node corresponding to the field `iter`. */
    final UnderscoreExpression getIter() { hcl_template_for_def(this, result) }

    /** Gets the node corresponding to the field `target`. */
    final Identifier getTarget(int i) { hcl_template_for_target(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_template_for_body(this, _, result) or
      hcl_template_for_def(this, result) or
      hcl_template_for_target(this, _, result)
    }
  }

  /** A class representing `template_if` nodes. */
  class TemplateIf extends @hcl_template_if, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TemplateIf" }

    /** Gets the node corresponding to the field `alternative`. */
    final AstNode getAlternative(int i) { hcl_template_if_alternative(this, i, result) }

    /** Gets the node corresponding to the field `body`. */
    final AstNode getBody(int i) { hcl_template_if_body(this, i, result) }

    /** Gets the node corresponding to the field `condition`. */
    final UnderscoreExpression getCondition() { hcl_template_if_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      hcl_template_if_alternative(this, _, result) or
      hcl_template_if_body(this, _, result) or
      hcl_template_if_def(this, result)
    }
  }

  /** A class representing `template_interpolation` nodes. */
  class TemplateInterpolation extends @hcl_template_interpolation, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TemplateInterpolation" }

    /** Gets the node corresponding to the field `expr`. */
    final UnderscoreExpression getExpr() { hcl_template_interpolation_expr(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_template_interpolation_expr(this, result) }
  }

  /** A class representing `template_literal` tokens. */
  class TemplateLiteral extends @hcl_token_template_literal, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TemplateLiteral" }
  }

  /** A class representing `tuple` nodes. */
  class Tuple extends @hcl_tuple, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Tuple" }

    /** Gets the node corresponding to the field `element`. */
    final UnderscoreExpression getElement(int i) { hcl_tuple_element(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_tuple_element(this, _, result) }
  }

  /** A class representing `unary_operation` nodes. */
  class UnaryOperation extends @hcl_unary_operation, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UnaryOperation" }

    /** Gets the node corresponding to the field `operand`. */
    final UnderscoreExprTerm getOperand() { hcl_unary_operation_def(this, result, _) }

    /** Gets the node corresponding to the field `operator`. */
    final string getOperator() {
      exists(int value | hcl_unary_operation_def(this, _, value) |
        result = "!" and value = 0
        or
        result = "-" and value = 1
      )
    }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_unary_operation_def(this, result, _) }
  }

  /** A class representing `variable_expr` nodes. */
  class VariableExpr extends @hcl_variable_expr, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "VariableExpr" }

    /** Gets the node corresponding to the field `name`. */
    final Identifier getName() { hcl_variable_expr_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { hcl_variable_expr_def(this, result) }
  }
}

module DOCKERFILE {
  /** The base class for all AST nodes */
  class AstNode extends @dockerfile_ast_node {
    /** Gets a string representation of this element. */
    string toString() { result = this.getAPrimaryQlClass() }

    /** Gets the location of this element. */
    final L::Location getLocation() { dockerfile_ast_node_info(this, _, _, result) }

    /** Gets the parent of this element. */
    final AstNode getParent() { dockerfile_ast_node_info(this, result, _, _) }

    /** Gets the index of this node among the children of its parent. */
    final int getParentIndex() { dockerfile_ast_node_info(this, _, result, _) }

    /** Gets a field or child node of this node. */
    AstNode getAFieldOrChild() { none() }

    /** Gets the name of the primary QL class for this element. */
    string getAPrimaryQlClass() { result = "???" }

    /** Gets a comma-separated list of the names of the primary CodeQL classes to which this element belongs. */
    string getPrimaryQlClasses() { result = concat(this.getAPrimaryQlClass(), ",") }
  }

  /** A token. */
  class Token extends @dockerfile_token, AstNode {
    /** Gets the value of this token. */
    final string getValue() { dockerfile_tokeninfo(this, _, result) }

    /** Gets a string representation of this element. */
    final override string toString() { result = this.getValue() }

    /** Gets the name of the primary QL class for this element. */
    override string getAPrimaryQlClass() { result = "Token" }
  }

  /** A reserved word. */
  class ReservedWord extends @dockerfile_reserved_word, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ReservedWord" }
  }

  /** A class representing `add_instruction` nodes. */
  class AddInstruction extends @dockerfile_add_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "AddInstruction" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_add_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_add_instruction_child(this, _, result) }
  }

  /** A class representing `arg_instruction` nodes. */
  class ArgInstruction extends @dockerfile_arg_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ArgInstruction" }

    /** Gets the node corresponding to the field `default`. */
    final AstNode getDefault() { dockerfile_arg_instruction_default(this, result) }

    /** Gets the node corresponding to the field `name`. */
    final UnquotedString getName() { dockerfile_arg_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_arg_instruction_default(this, result) or
      dockerfile_arg_instruction_def(this, result)
    }
  }

  /** A class representing `cmd_instruction` nodes. */
  class CmdInstruction extends @dockerfile_cmd_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "CmdInstruction" }

    /** Gets the child of this node. */
    final AstNode getChild() { dockerfile_cmd_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_cmd_instruction_def(this, result) }
  }

  /** A class representing `comment` tokens. */
  class Comment extends @dockerfile_token_comment, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Comment" }
  }

  /** A class representing `copy_instruction` nodes. */
  class CopyInstruction extends @dockerfile_copy_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "CopyInstruction" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_copy_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_copy_instruction_child(this, _, result) }
  }

  /** A class representing `cross_build_instruction` tokens. */
  class CrossBuildInstruction extends @dockerfile_token_cross_build_instruction, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "CrossBuildInstruction" }
  }

  /** A class representing `double_quoted_string` nodes. */
  class DoubleQuotedString extends @dockerfile_double_quoted_string, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "DoubleQuotedString" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_double_quoted_string_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_double_quoted_string_child(this, _, result)
    }
  }

  /** A class representing `entrypoint_instruction` nodes. */
  class EntrypointInstruction extends @dockerfile_entrypoint_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "EntrypointInstruction" }

    /** Gets the child of this node. */
    final AstNode getChild() { dockerfile_entrypoint_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_entrypoint_instruction_def(this, result)
    }
  }

  /** A class representing `env_instruction` nodes. */
  class EnvInstruction extends @dockerfile_env_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "EnvInstruction" }

    /** Gets the `i`th child of this node. */
    final EnvPair getChild(int i) { dockerfile_env_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_env_instruction_child(this, _, result) }
  }

  /** A class representing `env_pair` nodes. */
  class EnvPair extends @dockerfile_env_pair, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "EnvPair" }

    /** Gets the node corresponding to the field `name`. */
    final UnquotedString getName() { dockerfile_env_pair_def(this, result) }

    /** Gets the node corresponding to the field `value`. */
    final AstNode getValue() { dockerfile_env_pair_value(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_env_pair_def(this, result) or dockerfile_env_pair_value(this, result)
    }
  }

  /** A class representing `escape_sequence` tokens. */
  class EscapeSequence extends @dockerfile_token_escape_sequence, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "EscapeSequence" }
  }

  /** A class representing `expansion` nodes. */
  class Expansion extends @dockerfile_expansion, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Expansion" }

    /** Gets the child of this node. */
    final Variable getChild() { dockerfile_expansion_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_expansion_def(this, result) }
  }

  /** A class representing `expose_instruction` nodes. */
  class ExposeInstruction extends @dockerfile_expose_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ExposeInstruction" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_expose_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_expose_instruction_child(this, _, result)
    }
  }

  /** A class representing `expose_port` tokens. */
  class ExposePort extends @dockerfile_token_expose_port, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ExposePort" }
  }

  /** A class representing `from_instruction` nodes. */
  class FromInstruction extends @dockerfile_from_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "FromInstruction" }

    /** Gets the node corresponding to the field `as`. */
    final ImageAlias getAs() { dockerfile_from_instruction_as(this, result) }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_from_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_from_instruction_as(this, result) or
      dockerfile_from_instruction_child(this, _, result)
    }
  }

  /** A class representing `healthcheck_instruction` nodes. */
  class HealthcheckInstruction extends @dockerfile_healthcheck_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HealthcheckInstruction" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_healthcheck_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_healthcheck_instruction_child(this, _, result)
    }
  }

  /** A class representing `heredoc_block` nodes. */
  class HeredocBlock extends @dockerfile_heredoc_block, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HeredocBlock" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_heredoc_block_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_heredoc_block_child(this, _, result) }
  }

  /** A class representing `heredoc_end` tokens. */
  class HeredocEnd extends @dockerfile_token_heredoc_end, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HeredocEnd" }
  }

  /** A class representing `heredoc_line` tokens. */
  class HeredocLine extends @dockerfile_token_heredoc_line, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HeredocLine" }
  }

  /** A class representing `heredoc_marker` tokens. */
  class HeredocMarker extends @dockerfile_token_heredoc_marker, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HeredocMarker" }
  }

  /** A class representing `image_alias` nodes. */
  class ImageAlias extends @dockerfile_image_alias, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageAlias" }

    /** Gets the `i`th child of this node. */
    final Expansion getChild(int i) { dockerfile_image_alias_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_image_alias_child(this, _, result) }
  }

  /** A class representing `image_digest` nodes. */
  class ImageDigest extends @dockerfile_image_digest, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageDigest" }

    /** Gets the `i`th child of this node. */
    final Expansion getChild(int i) { dockerfile_image_digest_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_image_digest_child(this, _, result) }
  }

  /** A class representing `image_name` nodes. */
  class ImageName extends @dockerfile_image_name, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageName" }

    /** Gets the `i`th child of this node. */
    final Expansion getChild(int i) { dockerfile_image_name_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_image_name_child(this, _, result) }
  }

  /** A class representing `image_spec` nodes. */
  class ImageSpec extends @dockerfile_image_spec, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageSpec" }

    /** Gets the node corresponding to the field `digest`. */
    final ImageDigest getDigest() { dockerfile_image_spec_digest(this, result) }

    /** Gets the node corresponding to the field `name`. */
    final ImageName getName() { dockerfile_image_spec_def(this, result) }

    /** Gets the node corresponding to the field `tag`. */
    final ImageTag getTag() { dockerfile_image_spec_tag(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_image_spec_digest(this, result) or
      dockerfile_image_spec_def(this, result) or
      dockerfile_image_spec_tag(this, result)
    }
  }

  /** A class representing `image_tag` nodes. */
  class ImageTag extends @dockerfile_image_tag, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageTag" }

    /** Gets the `i`th child of this node. */
    final Expansion getChild(int i) { dockerfile_image_tag_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_image_tag_child(this, _, result) }
  }

  /** A class representing `json_string` nodes. */
  class JsonString extends @dockerfile_json_string, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "JsonString" }

    /** Gets the `i`th child of this node. */
    final EscapeSequence getChild(int i) { dockerfile_json_string_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_json_string_child(this, _, result) }
  }

  /** A class representing `json_string_array` nodes. */
  class JsonStringArray extends @dockerfile_json_string_array, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "JsonStringArray" }

    /** Gets the `i`th child of this node. */
    final JsonString getChild(int i) { dockerfile_json_string_array_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_json_string_array_child(this, _, result)
    }
  }

  /** A class representing `label_instruction` nodes. */
  class LabelInstruction extends @dockerfile_label_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "LabelInstruction" }

    /** Gets the `i`th child of this node. */
    final LabelPair getChild(int i) { dockerfile_label_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_label_instruction_child(this, _, result)
    }
  }

  /** A class representing `label_pair` nodes. */
  class LabelPair extends @dockerfile_label_pair, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "LabelPair" }

    /** Gets the node corresponding to the field `key`. */
    final AstNode getKey() { dockerfile_label_pair_def(this, result, _) }

    /** Gets the node corresponding to the field `value`. */
    final AstNode getValue() { dockerfile_label_pair_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_label_pair_def(this, result, _) or dockerfile_label_pair_def(this, _, result)
    }
  }

  /** A class representing `line_continuation` tokens. */
  class LineContinuation extends @dockerfile_token_line_continuation, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "LineContinuation" }
  }

  /** A class representing `maintainer_instruction` tokens. */
  class MaintainerInstruction extends @dockerfile_token_maintainer_instruction, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "MaintainerInstruction" }
  }

  /** A class representing `mount_param` nodes. */
  class MountParam extends @dockerfile_mount_param, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "MountParam" }

    /** Gets the node corresponding to the field `name`. */
    final string getName() {
      exists(int value | dockerfile_mount_param_def(this, value) | (result = "mount" and value = 0))
    }

    /** Gets the node corresponding to the field `value`. */
    final AstNode getValue(int i) { dockerfile_mount_param_value(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_mount_param_value(this, _, result) }
  }

  /** A class representing `mount_param_param` tokens. */
  class MountParamParam extends @dockerfile_token_mount_param_param, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "MountParamParam" }
  }

  /** A class representing `onbuild_instruction` nodes. */
  class OnbuildInstruction extends @dockerfile_onbuild_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "OnbuildInstruction" }

    /** Gets the child of this node. */
    final AstNode getChild() { dockerfile_onbuild_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_onbuild_instruction_def(this, result) }
  }

  /** A class representing `param` tokens. */
  class Param extends @dockerfile_token_param, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Param" }
  }

  /** A class representing `path` nodes. */
  class Path extends @dockerfile_path, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Path" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_path_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_path_child(this, _, result) }
  }

  /** A class representing `run_instruction` nodes. */
  class RunInstruction extends @dockerfile_run_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "RunInstruction" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_run_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_run_instruction_child(this, _, result) }
  }

  /** A class representing `shell_command` nodes. */
  class ShellCommand extends @dockerfile_shell_command, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ShellCommand" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_shell_command_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_shell_command_child(this, _, result) }
  }

  /** A class representing `shell_fragment` nodes. */
  class ShellFragment extends @dockerfile_shell_fragment, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ShellFragment" }

    /** Gets the `i`th child of this node. */
    final HeredocMarker getChild(int i) { dockerfile_shell_fragment_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_shell_fragment_child(this, _, result) }
  }

  /** A class representing `shell_instruction` nodes. */
  class ShellInstruction extends @dockerfile_shell_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ShellInstruction" }

    /** Gets the child of this node. */
    final JsonStringArray getChild() { dockerfile_shell_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_shell_instruction_def(this, result) }
  }

  /** A class representing `single_quoted_string` nodes. */
  class SingleQuotedString extends @dockerfile_single_quoted_string, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "SingleQuotedString" }

    /** Gets the `i`th child of this node. */
    final EscapeSequence getChild(int i) { dockerfile_single_quoted_string_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_single_quoted_string_child(this, _, result)
    }
  }

  /** A class representing `source_file` nodes. */
  class SourceFile extends @dockerfile_source_file, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "SourceFile" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_source_file_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_source_file_child(this, _, result) }
  }

  /** A class representing `stopsignal_instruction` nodes. */
  class StopsignalInstruction extends @dockerfile_stopsignal_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "StopsignalInstruction" }

    /** Gets the `i`th child of this node. */
    final Expansion getChild(int i) { dockerfile_stopsignal_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_stopsignal_instruction_child(this, _, result)
    }
  }

  /** A class representing `unquoted_string` nodes. */
  class UnquotedString extends @dockerfile_unquoted_string, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UnquotedString" }

    /** Gets the `i`th child of this node. */
    final Expansion getChild(int i) { dockerfile_unquoted_string_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_unquoted_string_child(this, _, result) }
  }

  /** A class representing `user_instruction` nodes. */
  class UserInstruction extends @dockerfile_user_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UserInstruction" }

    /** Gets the node corresponding to the field `group`. */
    final UnquotedString getGroup() { dockerfile_user_instruction_group(this, result) }

    /** Gets the node corresponding to the field `user`. */
    final UnquotedString getUser() { dockerfile_user_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_user_instruction_group(this, result) or
      dockerfile_user_instruction_def(this, result)
    }
  }

  /** A class representing `variable` tokens. */
  class Variable extends @dockerfile_token_variable, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Variable" }
  }

  /** A class representing `volume_instruction` nodes. */
  class VolumeInstruction extends @dockerfile_volume_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "VolumeInstruction" }

    /** Gets the `i`th child of this node. */
    final AstNode getChild(int i) { dockerfile_volume_instruction_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      dockerfile_volume_instruction_child(this, _, result)
    }
  }

  /** A class representing `workdir_instruction` nodes. */
  class WorkdirInstruction extends @dockerfile_workdir_instruction, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "WorkdirInstruction" }

    /** Gets the child of this node. */
    final Path getChild() { dockerfile_workdir_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { dockerfile_workdir_instruction_def(this, result) }
  }
}

module BICEP {
  /** The base class for all AST nodes */
  class AstNode extends @bicep_ast_node {
    /** Gets a string representation of this element. */
    string toString() { result = this.getAPrimaryQlClass() }

    /** Gets the location of this element. */
    final L::Location getLocation() { bicep_ast_node_info(this, _, _, result) }

    /** Gets the parent of this element. */
    final AstNode getParent() { bicep_ast_node_info(this, result, _, _) }

    /** Gets the index of this node among the children of its parent. */
    final int getParentIndex() { bicep_ast_node_info(this, _, result, _) }

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
