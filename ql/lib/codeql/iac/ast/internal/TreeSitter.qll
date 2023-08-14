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
    final UnquotedString getKey() { dockerfile_label_pair_def(this, result, _) }

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
    final Expansion getChild(int i) { dockerfile_path_child(this, i, result) }

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

  /** A class representing `shell_fragment` tokens. */
  class ShellFragment extends @dockerfile_token_shell_fragment, Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ShellFragment" }
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
