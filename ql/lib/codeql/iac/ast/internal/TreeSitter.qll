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

module JSON {
  /** The base class for all AST nodes */
  class AstNode extends @json_ast_node {
    /** Gets a string representation of this element. */
    string toString() { result = this.getAPrimaryQlClass() }

    /** Gets the location of this element. */
    final L::Location getLocation() { json_ast_node_info(this, _, _, result) }

    /** Gets the parent of this element. */
    final AstNode getParent() { json_ast_node_info(this, result, _, _) }

    /** Gets the index of this node among the children of its parent. */
    final int getParentIndex() { json_ast_node_info(this, _, result, _) }

    /** Gets a field or child node of this node. */
    AstNode getAFieldOrChild() { none() }

    /** Gets the name of the primary QL class for this element. */
    string getAPrimaryQlClass() { result = "???" }

    /** Gets a comma-separated list of the names of the primary CodeQL classes to which this element belongs. */
    string getPrimaryQlClasses() { result = concat(this.getAPrimaryQlClass(), ",") }
  }

  /** A token. */
  class Token extends @json_token, AstNode {
    /** Gets the value of this token. */
    final string getValue() { json_tokeninfo(this, _, result) }

    /** Gets a string representation of this element. */
    final override string toString() { result = this.getValue() }

    /** Gets the name of the primary QL class for this element. */
    override string getAPrimaryQlClass() { result = "Token" }
  }

  /** A reserved word. */
  class ReservedWord extends @json_reserved_word, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ReservedWord" }
  }

  /** A class representing `array` nodes. */
  class Array extends @json_array, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Array" }

    /** Gets the `i`th child of this node. */
    final Value getChild(int i) { json_array_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { json_array_child(this, _, result) }
  }

  /** A class representing `comment` tokens. */
  class Comment extends @json_token_comment, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Comment" }
  }

  /** A class representing `document` nodes. */
  class Document extends @json_document, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Document" }

    /** Gets the `i`th child of this node. */
    final Value getChild(int i) { json_document_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { json_document_child(this, _, result) }
  }

  /** A class representing `false` tokens. */
  class False extends @json_token_false, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "False" }
  }

  /** A class representing `null` tokens. */
  class Null extends @json_token_null, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Null" }
  }

  /** A class representing `number` tokens. */
  class Number extends @json_token_number, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Number" }
  }

  /** A class representing `object` nodes. */
  class Object extends @json_object, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Object" }

    /** Gets the `i`th child of this node. */
    final Pair getChild(int i) { json_object_child(this, i, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { json_object_child(this, _, result) }
  }

  /** A class representing `pair` nodes. */
  class Pair extends @json_pair, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Pair" }

    /** Gets the node corresponding to the field `key`. */
    final AstNode getKey() { json_pair_def(this, result, _) }

    /** Gets the node corresponding to the field `value`. */
    final Value getValue() { json_pair_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() {
      json_pair_def(this, result, _) or json_pair_def(this, _, result)
    }
  }

  /** A class representing `string` nodes. */
  class String extends @json_string__, AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "String" }

    /** Gets the child of this node. */
    final StringContent getChild() { json_string_child(this, result) }

    /** Gets a field or child node of this node. */
    final override AstNode getAFieldOrChild() { json_string_child(this, result) }
  }

  /** A class representing `string_content` tokens. */
  class StringContent extends @json_token_string_content, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "StringContent" }
  }

  /** A class representing `true` tokens. */
  class True extends @json_token_true, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "True" }
  }

  class Value extends @json_value, AstNode { }
}
