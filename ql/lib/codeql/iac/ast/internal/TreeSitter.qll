/**
 * CodeQL library for HCL
 * Automatically generated from the tree-sitter grammar; do not edit
 */

import codeql.Locations as L

/** Holds if the database is an overlay. */
overlay[local]
private predicate isOverlay() { databaseMetadata("isOverlay", "true") }

/** Holds if `loc` is in the `file` and is part of the overlay base database. */
overlay[local]
private predicate discardableLocation(@file file, @location_default loc) {
  not isOverlay() and locations_default(loc, file, _, _, _, _)
}

/** Holds if `loc` should be discarded, because it is part of the overlay base and is in a file that was also extracted as part of the overlay database. */
overlay[discard_entity]
private predicate discardLocation(@location_default loc) {
  exists(@file file, string path | files(file, path) |
    discardableLocation(file, loc) and overlayChangedFiles(path)
  )
}

overlay[local]
module HCL {
  private module F = HCL;

  /** The base class for all AST nodes */
  class AstNode extends @hcl_ast_node {
    /** Gets a string representation of this element. */
    string toString() { result = this.getAPrimaryQlClass() }

    /** Gets the location of this element. */
    final L::Location getLocation() { hcl_ast_node_location(this, result) }

    /** Gets the parent of this element. */
    final F::AstNode getParent() { hcl_ast_node_parent(this, result, _) }

    /** Gets the index of this node among the children of its parent. */
    final int getParentIndex() { hcl_ast_node_parent(this, _, result) }

    /** Gets a field or child node of this node. */
    F::AstNode getAFieldOrChild() { none() }

    /** Gets the name of the primary QL class for this element. */
    string getAPrimaryQlClass() { result = "???" }

    /** Gets a comma-separated list of the names of the primary CodeQL classes to which this element belongs. */
    string getPrimaryQlClasses() { result = concat(this.getAPrimaryQlClass(), ",") }
  }

  /** A token. */
  class Token extends @hcl_token, F::AstNode {
    /** Gets the value of this token. */
    final string getValue() { hcl_tokeninfo(this, _, result) }

    /** Gets a string representation of this element. */
    final override string toString() { result = this.getValue() }

    /** Gets the name of the primary QL class for this element. */
    override string getAPrimaryQlClass() { result = "Token" }
  }

  /** A reserved word. */
  class ReservedWord extends @hcl_reserved_word, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ReservedWord" }
  }

  /** Gets the file containing the given `node`. */
  private @file getNodeFile(@hcl_ast_node node) {
    exists(@location_default loc | hcl_ast_node_location(node, loc) |
      locations_default(loc, result, _, _, _, _)
    )
  }

  /** Holds if `node` is in the `file` and is part of the overlay base database. */
  private predicate discardableAstNode(@file file, @hcl_ast_node node) {
    not isOverlay() and file = getNodeFile(node)
  }

  /** Holds if `node` should be discarded, because it is part of the overlay base and is in a file that was also extracted as part of the overlay database. */
  overlay[discard_entity]
  private predicate discardAstNode(@hcl_ast_node node) {
    exists(@file file, string path | files(file, path) |
      discardableAstNode(file, node) and overlayChangedFiles(path)
    )
  }

  class UnderscoreCollectionValue extends @hcl_underscore_collection_value, F::UnderscoreExprTerm {
  }

  class UnderscoreExprTerm extends @hcl_underscore_expr_term, F::UnderscoreExpression { }

  class UnderscoreExpression extends @hcl_underscore_expression, F::AstNode { }

  class UnderscoreLiteralValue extends @hcl_underscore_literal_value, F::UnderscoreExprTerm { }

  class UnderscoreOperation extends @hcl_underscore_operation, F::UnderscoreExprTerm { }

  class UnderscoreSplat extends @hcl_underscore_splat, F::AstNode { }

  class UnderscoreTemplateDirective extends @hcl_underscore_template_directive, F::AstNode { }

  class UnderscoreTemplateExpr extends @hcl_underscore_template_expr, F::UnderscoreExprTerm { }

  /** A class representing `attr_splat` nodes. */
  class AttrSplat extends @hcl_attr_splat, F::UnderscoreSplat {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "AttrSplat" }

    /** Gets the node corresponding to the field `element`. */
    final F::GetAttr getElement(int i) { hcl_attr_splat_element(this, i, result) }

    /** Gets the node corresponding to the field `element`. */
    final F::GetAttr getAnElement() { result = this.getElement(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_attr_splat_element(this, _, result) }
  }

  /** A class representing `attribute` nodes. */
  class Attribute extends @hcl_attribute, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Attribute" }

    /** Gets the node corresponding to the field `key`. */
    final F::Identifier getKey() { hcl_attribute_def(this, result, _) }

    /** Gets the node corresponding to the field `val`. */
    final F::UnderscoreExpression getVal() { hcl_attribute_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_attribute_def(this, result, _) or hcl_attribute_def(this, _, result)
    }
  }

  /** A class representing `binary_operation` nodes. */
  class BinaryOperation extends @hcl_binary_operation, F::UnderscoreOperation {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "BinaryOperation" }

    /** Gets the node corresponding to the field `left`. */
    final F::UnderscoreExprTerm getLeft() { hcl_binary_operation_def(this, result, _, _) }

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
    final F::UnderscoreExprTerm getRight() { hcl_binary_operation_def(this, _, _, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_binary_operation_def(this, result, _, _) or hcl_binary_operation_def(this, _, _, result)
    }
  }

  /** A class representing `block` nodes. */
  class Block extends @hcl_block, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Block" }

    /** Gets the node corresponding to the field `body`. */
    final F::Body getBody() { hcl_block_body(this, result) }

    /** Gets the node corresponding to the field `label`. */
    final F::AstNode getLabel(int i) { hcl_block_label(this, i, result) }

    /** Gets the node corresponding to the field `label`. */
    final F::AstNode getALabel() { result = this.getLabel(_) }

    /** Gets the node corresponding to the field `type`. */
    final F::Identifier getType() { hcl_block_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_block_body(this, result) or
      hcl_block_label(this, _, result) or
      hcl_block_def(this, result)
    }
  }

  /** A class representing `body` nodes. */
  class Body extends @hcl_body, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Body" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { hcl_body_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_body_child(this, _, result) }
  }

  /** A class representing `bool_lit` tokens. */
  class BoolLit extends @hcl_token_bool_lit, F::Token, F::UnderscoreLiteralValue {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "BoolLit" }
  }

  /** A class representing `comment` tokens. */
  class Comment extends @hcl_token_comment, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Comment" }
  }

  /** A class representing `conditional` nodes. */
  class Conditional extends @hcl_conditional, F::UnderscoreExpression {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Conditional" }

    /** Gets the node corresponding to the field `alternative`. */
    final F::UnderscoreExpression getAlternative() { hcl_conditional_def(this, result, _, _) }

    /** Gets the node corresponding to the field `body`. */
    final F::UnderscoreExpression getBody() { hcl_conditional_def(this, _, result, _) }

    /** Gets the node corresponding to the field `condition`. */
    final F::UnderscoreExpression getCondition() { hcl_conditional_def(this, _, _, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_conditional_def(this, result, _, _) or
      hcl_conditional_def(this, _, result, _) or
      hcl_conditional_def(this, _, _, result)
    }
  }

  /** A class representing `config_file` nodes. */
  class ConfigFile extends @hcl_config_file, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ConfigFile" }

    /** Gets the child of this node. */
    final F::AstNode getChild() { hcl_config_file_child(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_config_file_child(this, result) }
  }

  /** A class representing `ellipsis` tokens. */
  class Ellipsis extends @hcl_token_ellipsis, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Ellipsis" }
  }

  /** A class representing `for_expr` nodes. */
  class ForExpr extends @hcl_for_expr, F::UnderscoreExprTerm {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ForExpr" }

    /** Gets the child of this node. */
    final F::AstNode getChild() { hcl_for_expr_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_for_expr_def(this, result) }
  }

  /** A class representing `for_object_expr` nodes. */
  class ForObjectExpr extends @hcl_for_object_expr, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ForObjectExpr" }

    /** Gets the node corresponding to the field `condition`. */
    final F::UnderscoreExpression getCondition() { hcl_for_object_expr_condition(this, result) }

    /** Gets the node corresponding to the field `iter`. */
    final F::UnderscoreExpression getIter() { hcl_for_object_expr_def(this, result, _, _) }

    /** Gets the node corresponding to the field `key`. */
    final F::UnderscoreExpression getKey() { hcl_for_object_expr_def(this, _, result, _) }

    /** Gets the node corresponding to the field `target`. */
    final F::Identifier getTarget(int i) { hcl_for_object_expr_target(this, i, result) }

    /** Gets the node corresponding to the field `target`. */
    final F::Identifier getATarget() { result = this.getTarget(_) }

    /** Gets the node corresponding to the field `val`. */
    final F::UnderscoreExpression getVal() { hcl_for_object_expr_def(this, _, _, result) }

    /** Gets the child of this node. */
    final F::Ellipsis getChild() { hcl_for_object_expr_child(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_for_object_expr_condition(this, result) or
      hcl_for_object_expr_def(this, result, _, _) or
      hcl_for_object_expr_def(this, _, result, _) or
      hcl_for_object_expr_target(this, _, result) or
      hcl_for_object_expr_def(this, _, _, result) or
      hcl_for_object_expr_child(this, result)
    }
  }

  /** A class representing `for_tuple_expr` nodes. */
  class ForTupleExpr extends @hcl_for_tuple_expr, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ForTupleExpr" }

    /** Gets the node corresponding to the field `condition`. */
    final F::UnderscoreExpression getCondition() { hcl_for_tuple_expr_condition(this, result) }

    /** Gets the node corresponding to the field `expr`. */
    final F::UnderscoreExpression getExpr() { hcl_for_tuple_expr_def(this, result, _) }

    /** Gets the node corresponding to the field `iter`. */
    final F::UnderscoreExpression getIter() { hcl_for_tuple_expr_def(this, _, result) }

    /** Gets the node corresponding to the field `target`. */
    final F::Identifier getTarget(int i) { hcl_for_tuple_expr_target(this, i, result) }

    /** Gets the node corresponding to the field `target`. */
    final F::Identifier getATarget() { result = this.getTarget(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_for_tuple_expr_condition(this, result) or
      hcl_for_tuple_expr_def(this, result, _) or
      hcl_for_tuple_expr_def(this, _, result) or
      hcl_for_tuple_expr_target(this, _, result)
    }
  }

  /** A class representing `full_splat` nodes. */
  class FullSplat extends @hcl_full_splat, F::UnderscoreSplat {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "FullSplat" }

    /** Gets the node corresponding to the field `element`. */
    final F::AstNode getElement(int i) { hcl_full_splat_element(this, i, result) }

    /** Gets the node corresponding to the field `element`. */
    final F::AstNode getAnElement() { result = this.getElement(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_full_splat_element(this, _, result) }
  }

  /** A class representing `function_call` nodes. */
  class FunctionCall extends @hcl_function_call, F::UnderscoreExprTerm {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "FunctionCall" }

    /** Gets the node corresponding to the field `argument`. */
    final F::UnderscoreExpression getArgument(int i) { hcl_function_call_argument(this, i, result) }

    /** Gets the node corresponding to the field `argument`. */
    final F::UnderscoreExpression getAnArgument() { result = this.getArgument(_) }

    /** Gets the node corresponding to the field `function`. */
    final F::Identifier getFunction() { hcl_function_call_def(this, result) }

    /** Gets the child of this node. */
    final F::Ellipsis getChild() { hcl_function_call_child(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_function_call_argument(this, _, result) or
      hcl_function_call_def(this, result) or
      hcl_function_call_child(this, result)
    }
  }

  /** A class representing `get_attr` nodes. */
  class GetAttr extends @hcl_get_attr, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "GetAttr" }

    /** Gets the node corresponding to the field `key`. */
    final F::Identifier getKey() { hcl_get_attr_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_get_attr_def(this, result) }
  }

  /** A class representing `get_attr_expr` nodes. */
  class GetAttrExpr extends @hcl_get_attr_expr, F::UnderscoreExprTerm {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "GetAttrExpr" }

    /** Gets the node corresponding to the field `expr`. */
    final F::UnderscoreExprTerm getExpr() { hcl_get_attr_expr_def(this, result, _) }

    /** Gets the node corresponding to the field `key`. */
    final F::Identifier getKey() { hcl_get_attr_expr_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_get_attr_expr_def(this, result, _) or hcl_get_attr_expr_def(this, _, result)
    }
  }

  /** A class representing `heredoc_template` nodes. */
  class HeredocTemplate extends @hcl_heredoc_template, F::UnderscoreTemplateExpr {
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
    final F::AstNode getChild(int i) { hcl_heredoc_template_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_heredoc_template_child(this, _, result) }
  }

  /** A class representing `identifier` tokens. */
  class Identifier extends @hcl_token_identifier, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Identifier" }
  }

  /** A class representing `index` nodes. */
  class Index extends @hcl_index, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Index" }

    /** Gets the node corresponding to the field `index`. */
    final F::AstNode getIndex() { hcl_index_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_index_def(this, result) }
  }

  /** A class representing `index_expr` nodes. */
  class IndexExpr extends @hcl_index_expr, F::UnderscoreExprTerm {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "IndexExpr" }

    /** Gets the node corresponding to the field `expr`. */
    final F::UnderscoreExprTerm getExpr() { hcl_index_expr_def(this, result, _) }

    /** Gets the node corresponding to the field `index`. */
    final F::AstNode getIndex() { hcl_index_expr_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_index_expr_def(this, result, _) or hcl_index_expr_def(this, _, result)
    }
  }

  /** A class representing `null_lit` tokens. */
  class NullLit extends @hcl_token_null_lit, F::Token, F::UnderscoreLiteralValue {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "NullLit" }
  }

  /** A class representing `numeric_lit` tokens. */
  class NumericLit extends @hcl_token_numeric_lit, F::Token, F::UnderscoreLiteralValue {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "NumericLit" }
  }

  /** A class representing `object` nodes. */
  class Object extends @hcl_object, F::UnderscoreCollectionValue {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Object" }

    /** Gets the node corresponding to the field `element`. */
    final F::ObjectElem getElement(int i) { hcl_object_element(this, i, result) }

    /** Gets the node corresponding to the field `element`. */
    final F::ObjectElem getAnElement() { result = this.getElement(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_object_element(this, _, result) }
  }

  /** A class representing `object_elem` nodes. */
  class ObjectElem extends @hcl_object_elem, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ObjectElem" }

    /** Gets the node corresponding to the field `key`. */
    final F::UnderscoreExpression getKey() { hcl_object_elem_def(this, result, _) }

    /** Gets the node corresponding to the field `val`. */
    final F::UnderscoreExpression getVal() { hcl_object_elem_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_object_elem_def(this, result, _) or hcl_object_elem_def(this, _, result)
    }
  }

  /** A class representing `parenthesized_expr` nodes. */
  class ParenthesizedExpr extends @hcl_parenthesized_expr, F::UnderscoreExprTerm {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ParenthesizedExpr" }

    /** Gets the child of this node. */
    final F::UnderscoreExpression getChild() { hcl_parenthesized_expr_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_parenthesized_expr_def(this, result) }
  }

  /** A class representing `quoted_template` nodes. */
  class QuotedTemplate extends @hcl_quoted_template, F::UnderscoreTemplateExpr {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "QuotedTemplate" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { hcl_quoted_template_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_quoted_template_child(this, _, result) }
  }

  /** A class representing `splat_expr` nodes. */
  class SplatExpr extends @hcl_splat_expr, F::UnderscoreExprTerm {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "SplatExpr" }

    /** Gets the node corresponding to the field `expr`. */
    final F::UnderscoreExprTerm getExpr() { hcl_splat_expr_def(this, result, _) }

    /** Gets the node corresponding to the field `splat`. */
    final F::UnderscoreSplat getSplat() { hcl_splat_expr_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_splat_expr_def(this, result, _) or hcl_splat_expr_def(this, _, result)
    }
  }

  /** A class representing `string_lit` nodes. */
  class StringLit extends @hcl_string_lit, F::UnderscoreLiteralValue {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "StringLit" }

    /** Gets the child of this node. */
    final F::TemplateLiteral getChild() { hcl_string_lit_child(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_string_lit_child(this, result) }
  }

  /** A class representing `template_for` nodes. */
  class TemplateFor extends @hcl_template_for, F::UnderscoreTemplateDirective {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TemplateFor" }

    /** Gets the node corresponding to the field `body`. */
    final F::AstNode getBody(int i) { hcl_template_for_body(this, i, result) }

    /** Gets the node corresponding to the field `body`. */
    final F::AstNode getABody() { result = this.getBody(_) }

    /** Gets the node corresponding to the field `iter`. */
    final F::UnderscoreExpression getIter() { hcl_template_for_def(this, result) }

    /** Gets the node corresponding to the field `target`. */
    final F::Identifier getTarget(int i) { hcl_template_for_target(this, i, result) }

    /** Gets the node corresponding to the field `target`. */
    final F::Identifier getATarget() { result = this.getTarget(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_template_for_body(this, _, result) or
      hcl_template_for_def(this, result) or
      hcl_template_for_target(this, _, result)
    }
  }

  /** A class representing `template_if` nodes. */
  class TemplateIf extends @hcl_template_if, F::UnderscoreTemplateDirective {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TemplateIf" }

    /** Gets the node corresponding to the field `alternative`. */
    final F::AstNode getAlternative(int i) { hcl_template_if_alternative(this, i, result) }

    /** Gets the node corresponding to the field `alternative`. */
    final F::AstNode getAnAlternative() { result = this.getAlternative(_) }

    /** Gets the node corresponding to the field `body`. */
    final F::AstNode getBody(int i) { hcl_template_if_body(this, i, result) }

    /** Gets the node corresponding to the field `body`. */
    final F::AstNode getABody() { result = this.getBody(_) }

    /** Gets the node corresponding to the field `condition`. */
    final F::UnderscoreExpression getCondition() { hcl_template_if_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      hcl_template_if_alternative(this, _, result) or
      hcl_template_if_body(this, _, result) or
      hcl_template_if_def(this, result)
    }
  }

  /** A class representing `template_interpolation` nodes. */
  class TemplateInterpolation extends @hcl_template_interpolation, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TemplateInterpolation" }

    /** Gets the node corresponding to the field `expr`. */
    final F::UnderscoreExpression getExpr() { hcl_template_interpolation_expr(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_template_interpolation_expr(this, result) }
  }

  /** A class representing `template_literal` tokens. */
  class TemplateLiteral extends @hcl_token_template_literal, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "TemplateLiteral" }
  }

  /** A class representing `tuple` nodes. */
  class Tuple extends @hcl_tuple, F::UnderscoreCollectionValue {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Tuple" }

    /** Gets the node corresponding to the field `element`. */
    final F::UnderscoreExpression getElement(int i) { hcl_tuple_element(this, i, result) }

    /** Gets the node corresponding to the field `element`. */
    final F::UnderscoreExpression getAnElement() { result = this.getElement(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_tuple_element(this, _, result) }
  }

  /** A class representing `unary_operation` nodes. */
  class UnaryOperation extends @hcl_unary_operation, F::UnderscoreOperation {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UnaryOperation" }

    /** Gets the node corresponding to the field `operand`. */
    final F::UnderscoreExprTerm getOperand() { hcl_unary_operation_def(this, result, _) }

    /** Gets the node corresponding to the field `operator`. */
    final string getOperator() {
      exists(int value | hcl_unary_operation_def(this, _, value) |
        result = "!" and value = 0
        or
        result = "-" and value = 1
      )
    }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_unary_operation_def(this, result, _) }
  }

  /** A class representing `variable_expr` nodes. */
  class VariableExpr extends @hcl_variable_expr, F::UnderscoreExprTerm {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "VariableExpr" }

    /** Gets the node corresponding to the field `name`. */
    final F::Identifier getName() { hcl_variable_expr_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { hcl_variable_expr_def(this, result) }
  }

  /** Provides predicates for mapping AST nodes to their named children. */
  module PrintAst {
    /** Gets a child of `node` returned by the member predicate with the given `name`. If the predicate takes an index argument, `i` is bound to that index, otherwise `i` is `-1` (which is never a valid index). */
    F::AstNode getChild(F::AstNode node, string name, int i) {
      result = node.(AttrSplat).getElement(i) and name = "getElement"
      or
      result = node.(Attribute).getKey() and i = -1 and name = "getKey"
      or
      result = node.(Attribute).getVal() and i = -1 and name = "getVal"
      or
      result = node.(BinaryOperation).getLeft() and i = -1 and name = "getLeft"
      or
      result = node.(BinaryOperation).getRight() and i = -1 and name = "getRight"
      or
      result = node.(Block).getBody() and i = -1 and name = "getBody"
      or
      result = node.(Block).getLabel(i) and name = "getLabel"
      or
      result = node.(Block).getType() and i = -1 and name = "getType"
      or
      result = node.(Body).getChild(i) and name = "getChild"
      or
      result = node.(Conditional).getAlternative() and i = -1 and name = "getAlternative"
      or
      result = node.(Conditional).getBody() and i = -1 and name = "getBody"
      or
      result = node.(Conditional).getCondition() and i = -1 and name = "getCondition"
      or
      result = node.(ConfigFile).getChild() and i = -1 and name = "getChild"
      or
      result = node.(ForExpr).getChild() and i = -1 and name = "getChild"
      or
      result = node.(ForObjectExpr).getCondition() and i = -1 and name = "getCondition"
      or
      result = node.(ForObjectExpr).getIter() and i = -1 and name = "getIter"
      or
      result = node.(ForObjectExpr).getKey() and i = -1 and name = "getKey"
      or
      result = node.(ForObjectExpr).getTarget(i) and name = "getTarget"
      or
      result = node.(ForObjectExpr).getVal() and i = -1 and name = "getVal"
      or
      result = node.(ForObjectExpr).getChild() and i = -1 and name = "getChild"
      or
      result = node.(ForTupleExpr).getCondition() and i = -1 and name = "getCondition"
      or
      result = node.(ForTupleExpr).getExpr() and i = -1 and name = "getExpr"
      or
      result = node.(ForTupleExpr).getIter() and i = -1 and name = "getIter"
      or
      result = node.(ForTupleExpr).getTarget(i) and name = "getTarget"
      or
      result = node.(FullSplat).getElement(i) and name = "getElement"
      or
      result = node.(FunctionCall).getArgument(i) and name = "getArgument"
      or
      result = node.(FunctionCall).getFunction() and i = -1 and name = "getFunction"
      or
      result = node.(FunctionCall).getChild() and i = -1 and name = "getChild"
      or
      result = node.(GetAttr).getKey() and i = -1 and name = "getKey"
      or
      result = node.(GetAttrExpr).getExpr() and i = -1 and name = "getExpr"
      or
      result = node.(GetAttrExpr).getKey() and i = -1 and name = "getKey"
      or
      result = node.(HeredocTemplate).getChild(i) and name = "getChild"
      or
      result = node.(Index).getIndex() and i = -1 and name = "getIndex"
      or
      result = node.(IndexExpr).getExpr() and i = -1 and name = "getExpr"
      or
      result = node.(IndexExpr).getIndex() and i = -1 and name = "getIndex"
      or
      result = node.(Object).getElement(i) and name = "getElement"
      or
      result = node.(ObjectElem).getKey() and i = -1 and name = "getKey"
      or
      result = node.(ObjectElem).getVal() and i = -1 and name = "getVal"
      or
      result = node.(ParenthesizedExpr).getChild() and i = -1 and name = "getChild"
      or
      result = node.(QuotedTemplate).getChild(i) and name = "getChild"
      or
      result = node.(SplatExpr).getExpr() and i = -1 and name = "getExpr"
      or
      result = node.(SplatExpr).getSplat() and i = -1 and name = "getSplat"
      or
      result = node.(StringLit).getChild() and i = -1 and name = "getChild"
      or
      result = node.(TemplateFor).getBody(i) and name = "getBody"
      or
      result = node.(TemplateFor).getIter() and i = -1 and name = "getIter"
      or
      result = node.(TemplateFor).getTarget(i) and name = "getTarget"
      or
      result = node.(TemplateIf).getAlternative(i) and name = "getAlternative"
      or
      result = node.(TemplateIf).getBody(i) and name = "getBody"
      or
      result = node.(TemplateIf).getCondition() and i = -1 and name = "getCondition"
      or
      result = node.(TemplateInterpolation).getExpr() and i = -1 and name = "getExpr"
      or
      result = node.(Tuple).getElement(i) and name = "getElement"
      or
      result = node.(UnaryOperation).getOperand() and i = -1 and name = "getOperand"
      or
      result = node.(VariableExpr).getName() and i = -1 and name = "getName"
    }
  }
}

module HCLFinal {
  private module F = HCL;

  import F

  final class AstNode = F::AstNode;

  final class Token = F::Token;

  final class ReservedWord = F::ReservedWord;

  final class UnderscoreCollectionValue = F::UnderscoreCollectionValue;

  final class UnderscoreExprTerm = F::UnderscoreExprTerm;

  final class UnderscoreExpression = F::UnderscoreExpression;

  final class UnderscoreLiteralValue = F::UnderscoreLiteralValue;

  final class UnderscoreOperation = F::UnderscoreOperation;

  final class UnderscoreSplat = F::UnderscoreSplat;

  final class UnderscoreTemplateDirective = F::UnderscoreTemplateDirective;

  final class UnderscoreTemplateExpr = F::UnderscoreTemplateExpr;

  final class AttrSplat = F::AttrSplat;

  final class Attribute = F::Attribute;

  final class BinaryOperation = F::BinaryOperation;

  final class Block = F::Block;

  final class Body = F::Body;

  final class BoolLit = F::BoolLit;

  final class Comment = F::Comment;

  final class Conditional = F::Conditional;

  final class ConfigFile = F::ConfigFile;

  final class Ellipsis = F::Ellipsis;

  final class ForExpr = F::ForExpr;

  final class ForObjectExpr = F::ForObjectExpr;

  final class ForTupleExpr = F::ForTupleExpr;

  final class FullSplat = F::FullSplat;

  final class FunctionCall = F::FunctionCall;

  final class GetAttr = F::GetAttr;

  final class GetAttrExpr = F::GetAttrExpr;

  final class HeredocTemplate = F::HeredocTemplate;

  final class Identifier = F::Identifier;

  final class Index = F::Index;

  final class IndexExpr = F::IndexExpr;

  final class NullLit = F::NullLit;

  final class NumericLit = F::NumericLit;

  final class Object = F::Object;

  final class ObjectElem = F::ObjectElem;

  final class ParenthesizedExpr = F::ParenthesizedExpr;

  final class QuotedTemplate = F::QuotedTemplate;

  final class SplatExpr = F::SplatExpr;

  final class StringLit = F::StringLit;

  final class TemplateFor = F::TemplateFor;

  final class TemplateIf = F::TemplateIf;

  final class TemplateInterpolation = F::TemplateInterpolation;

  final class TemplateLiteral = F::TemplateLiteral;

  final class Tuple = F::Tuple;

  final class UnaryOperation = F::UnaryOperation;

  final class VariableExpr = F::VariableExpr;
}

overlay[local]
module DOCKERFILE {
  private module F = DOCKERFILE;

  /** The base class for all AST nodes */
  class AstNode extends @dockerfile_ast_node {
    /** Gets a string representation of this element. */
    string toString() { result = this.getAPrimaryQlClass() }

    /** Gets the location of this element. */
    final L::Location getLocation() { dockerfile_ast_node_location(this, result) }

    /** Gets the parent of this element. */
    final F::AstNode getParent() { dockerfile_ast_node_parent(this, result, _) }

    /** Gets the index of this node among the children of its parent. */
    final int getParentIndex() { dockerfile_ast_node_parent(this, _, result) }

    /** Gets a field or child node of this node. */
    F::AstNode getAFieldOrChild() { none() }

    /** Gets the name of the primary QL class for this element. */
    string getAPrimaryQlClass() { result = "???" }

    /** Gets a comma-separated list of the names of the primary CodeQL classes to which this element belongs. */
    string getPrimaryQlClasses() { result = concat(this.getAPrimaryQlClass(), ",") }
  }

  /** A token. */
  class Token extends @dockerfile_token, F::AstNode {
    /** Gets the value of this token. */
    final string getValue() { dockerfile_tokeninfo(this, _, result) }

    /** Gets a string representation of this element. */
    final override string toString() { result = this.getValue() }

    /** Gets the name of the primary QL class for this element. */
    override string getAPrimaryQlClass() { result = "Token" }
  }

  /** A reserved word. */
  class ReservedWord extends @dockerfile_reserved_word, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ReservedWord" }
  }

  /** Gets the file containing the given `node`. */
  private @file getNodeFile(@dockerfile_ast_node node) {
    exists(@location_default loc | dockerfile_ast_node_location(node, loc) |
      locations_default(loc, result, _, _, _, _)
    )
  }

  /** Holds if `node` is in the `file` and is part of the overlay base database. */
  private predicate discardableAstNode(@file file, @dockerfile_ast_node node) {
    not isOverlay() and file = getNodeFile(node)
  }

  /** Holds if `node` should be discarded, because it is part of the overlay base and is in a file that was also extracted as part of the overlay database. */
  overlay[discard_entity]
  private predicate discardAstNode(@dockerfile_ast_node node) {
    exists(@file file, string path | files(file, path) |
      discardableAstNode(file, node) and overlayChangedFiles(path)
    )
  }

  /** A class representing `add_instruction` nodes. */
  class AddInstruction extends @dockerfile_add_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "AddInstruction" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_add_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_add_instruction_child(this, _, result)
    }
  }

  /** A class representing `arg_instruction` nodes. */
  class ArgInstruction extends @dockerfile_arg_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ArgInstruction" }

    /** Gets the node corresponding to the field `default`. */
    final F::AstNode getDefault() { dockerfile_arg_instruction_default(this, result) }

    /** Gets the node corresponding to the field `name`. */
    final F::UnquotedString getName() { dockerfile_arg_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_arg_instruction_default(this, result) or
      dockerfile_arg_instruction_def(this, result)
    }
  }

  /** A class representing `cmd_instruction` nodes. */
  class CmdInstruction extends @dockerfile_cmd_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "CmdInstruction" }

    /** Gets the child of this node. */
    final F::AstNode getChild() { dockerfile_cmd_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_cmd_instruction_def(this, result) }
  }

  /** A class representing `comment` tokens. */
  class Comment extends @dockerfile_token_comment, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Comment" }
  }

  /** A class representing `copy_instruction` nodes. */
  class CopyInstruction extends @dockerfile_copy_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "CopyInstruction" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_copy_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_copy_instruction_child(this, _, result)
    }
  }

  /** A class representing `cross_build_instruction` tokens. */
  class CrossBuildInstruction extends @dockerfile_token_cross_build_instruction, F::AstNode,
    F::Token
  {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "CrossBuildInstruction" }
  }

  /** A class representing `double_quoted_string` nodes. */
  class DoubleQuotedString extends @dockerfile_double_quoted_string, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "DoubleQuotedString" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_double_quoted_string_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_double_quoted_string_child(this, _, result)
    }
  }

  /** A class representing `entrypoint_instruction` nodes. */
  class EntrypointInstruction extends @dockerfile_entrypoint_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "EntrypointInstruction" }

    /** Gets the child of this node. */
    final F::AstNode getChild() { dockerfile_entrypoint_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_entrypoint_instruction_def(this, result)
    }
  }

  /** A class representing `env_instruction` nodes. */
  class EnvInstruction extends @dockerfile_env_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "EnvInstruction" }

    /** Gets the `i`th child of this node. */
    final F::EnvPair getChild(int i) { dockerfile_env_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::EnvPair getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_env_instruction_child(this, _, result)
    }
  }

  /** A class representing `env_pair` nodes. */
  class EnvPair extends @dockerfile_env_pair, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "EnvPair" }

    /** Gets the node corresponding to the field `name`. */
    final F::UnquotedString getName() { dockerfile_env_pair_def(this, result) }

    /** Gets the node corresponding to the field `value`. */
    final F::AstNode getValue() { dockerfile_env_pair_value(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_env_pair_def(this, result) or dockerfile_env_pair_value(this, result)
    }
  }

  /** A class representing `escape_sequence` tokens. */
  class EscapeSequence extends @dockerfile_token_escape_sequence, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "EscapeSequence" }
  }

  /** A class representing `expansion` nodes. */
  class Expansion extends @dockerfile_expansion, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Expansion" }

    /** Gets the child of this node. */
    final F::Variable getChild() { dockerfile_expansion_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_expansion_def(this, result) }
  }

  /** A class representing `expose_instruction` nodes. */
  class ExposeInstruction extends @dockerfile_expose_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ExposeInstruction" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_expose_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_expose_instruction_child(this, _, result)
    }
  }

  /** A class representing `expose_port` tokens. */
  class ExposePort extends @dockerfile_token_expose_port, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ExposePort" }
  }

  /** A class representing `from_instruction` nodes. */
  class FromInstruction extends @dockerfile_from_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "FromInstruction" }

    /** Gets the node corresponding to the field `as`. */
    final F::ImageAlias getAs() { dockerfile_from_instruction_as(this, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_from_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_from_instruction_as(this, result) or
      dockerfile_from_instruction_child(this, _, result)
    }
  }

  /** A class representing `healthcheck_instruction` nodes. */
  class HealthcheckInstruction extends @dockerfile_healthcheck_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HealthcheckInstruction" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_healthcheck_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_healthcheck_instruction_child(this, _, result)
    }
  }

  /** A class representing `heredoc_block` nodes. */
  class HeredocBlock extends @dockerfile_heredoc_block, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HeredocBlock" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_heredoc_block_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_heredoc_block_child(this, _, result) }
  }

  /** A class representing `heredoc_end` tokens. */
  class HeredocEnd extends @dockerfile_token_heredoc_end, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HeredocEnd" }
  }

  /** A class representing `heredoc_line` tokens. */
  class HeredocLine extends @dockerfile_token_heredoc_line, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HeredocLine" }
  }

  /** A class representing `heredoc_marker` tokens. */
  class HeredocMarker extends @dockerfile_token_heredoc_marker, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "HeredocMarker" }
  }

  /** A class representing `image_alias` nodes. */
  class ImageAlias extends @dockerfile_image_alias, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageAlias" }

    /** Gets the `i`th child of this node. */
    final F::Expansion getChild(int i) { dockerfile_image_alias_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::Expansion getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_image_alias_child(this, _, result) }
  }

  /** A class representing `image_digest` nodes. */
  class ImageDigest extends @dockerfile_image_digest, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageDigest" }

    /** Gets the `i`th child of this node. */
    final F::Expansion getChild(int i) { dockerfile_image_digest_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::Expansion getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_image_digest_child(this, _, result) }
  }

  /** A class representing `image_name` nodes. */
  class ImageName extends @dockerfile_image_name, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageName" }

    /** Gets the `i`th child of this node. */
    final F::Expansion getChild(int i) { dockerfile_image_name_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::Expansion getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_image_name_child(this, _, result) }
  }

  /** A class representing `image_spec` nodes. */
  class ImageSpec extends @dockerfile_image_spec, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageSpec" }

    /** Gets the node corresponding to the field `digest`. */
    final F::ImageDigest getDigest() { dockerfile_image_spec_digest(this, result) }

    /** Gets the node corresponding to the field `name`. */
    final F::ImageName getName() { dockerfile_image_spec_def(this, result) }

    /** Gets the node corresponding to the field `tag`. */
    final F::ImageTag getTag() { dockerfile_image_spec_tag(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_image_spec_digest(this, result) or
      dockerfile_image_spec_def(this, result) or
      dockerfile_image_spec_tag(this, result)
    }
  }

  /** A class representing `image_tag` nodes. */
  class ImageTag extends @dockerfile_image_tag, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ImageTag" }

    /** Gets the `i`th child of this node. */
    final F::Expansion getChild(int i) { dockerfile_image_tag_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::Expansion getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_image_tag_child(this, _, result) }
  }

  /** A class representing `json_string` nodes. */
  class JsonString extends @dockerfile_json_string, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "JsonString" }

    /** Gets the `i`th child of this node. */
    final F::EscapeSequence getChild(int i) { dockerfile_json_string_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::EscapeSequence getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_json_string_child(this, _, result) }
  }

  /** A class representing `json_string_array` nodes. */
  class JsonStringArray extends @dockerfile_json_string_array, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "JsonStringArray" }

    /** Gets the `i`th child of this node. */
    final F::JsonString getChild(int i) { dockerfile_json_string_array_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::JsonString getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_json_string_array_child(this, _, result)
    }
  }

  /** A class representing `label_instruction` nodes. */
  class LabelInstruction extends @dockerfile_label_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "LabelInstruction" }

    /** Gets the `i`th child of this node. */
    final F::LabelPair getChild(int i) { dockerfile_label_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::LabelPair getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_label_instruction_child(this, _, result)
    }
  }

  /** A class representing `label_pair` nodes. */
  class LabelPair extends @dockerfile_label_pair, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "LabelPair" }

    /** Gets the node corresponding to the field `key`. */
    final F::AstNode getKey() { dockerfile_label_pair_def(this, result, _) }

    /** Gets the node corresponding to the field `value`. */
    final F::AstNode getValue() { dockerfile_label_pair_def(this, _, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_label_pair_def(this, result, _) or dockerfile_label_pair_def(this, _, result)
    }
  }

  /** A class representing `line_continuation` tokens. */
  class LineContinuation extends @dockerfile_token_line_continuation, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "LineContinuation" }
  }

  /** A class representing `maintainer_instruction` tokens. */
  class MaintainerInstruction extends @dockerfile_token_maintainer_instruction, F::AstNode, F::Token
  {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "MaintainerInstruction" }
  }

  /** A class representing `mount_param` nodes. */
  class MountParam extends @dockerfile_mount_param, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "MountParam" }

    /** Gets the node corresponding to the field `name`. */
    final string getName() {
      exists(int value | dockerfile_mount_param_def(this, value) | (result = "mount" and value = 0))
    }

    /** Gets the node corresponding to the field `value`. */
    final F::AstNode getValue(int i) { dockerfile_mount_param_value(this, i, result) }

    /** Gets the node corresponding to the field `value`. */
    final F::AstNode getAValue() { result = this.getValue(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_mount_param_value(this, _, result) }
  }

  /** A class representing `mount_param_param` tokens. */
  class MountParamParam extends @dockerfile_token_mount_param_param, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "MountParamParam" }
  }

  /** A class representing `onbuild_instruction` nodes. */
  class OnbuildInstruction extends @dockerfile_onbuild_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "OnbuildInstruction" }

    /** Gets the child of this node. */
    final F::AstNode getChild() { dockerfile_onbuild_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_onbuild_instruction_def(this, result)
    }
  }

  /** A class representing `param` tokens. */
  class Param extends @dockerfile_token_param, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Param" }
  }

  /** A class representing `path` nodes. */
  class Path extends @dockerfile_path, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Path" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_path_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_path_child(this, _, result) }
  }

  /** A class representing `run_instruction` nodes. */
  class RunInstruction extends @dockerfile_run_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "RunInstruction" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_run_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_run_instruction_child(this, _, result)
    }
  }

  /** A class representing `shell_command` nodes. */
  class ShellCommand extends @dockerfile_shell_command, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ShellCommand" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_shell_command_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_shell_command_child(this, _, result) }
  }

  /** A class representing `shell_fragment` nodes. */
  class ShellFragment extends @dockerfile_shell_fragment, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ShellFragment" }

    /** Gets the `i`th child of this node. */
    final F::HeredocMarker getChild(int i) { dockerfile_shell_fragment_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::HeredocMarker getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_shell_fragment_child(this, _, result)
    }
  }

  /** A class representing `shell_instruction` nodes. */
  class ShellInstruction extends @dockerfile_shell_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "ShellInstruction" }

    /** Gets the child of this node. */
    final F::JsonStringArray getChild() { dockerfile_shell_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_shell_instruction_def(this, result) }
  }

  /** A class representing `single_quoted_string` nodes. */
  class SingleQuotedString extends @dockerfile_single_quoted_string, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "SingleQuotedString" }

    /** Gets the `i`th child of this node. */
    final F::EscapeSequence getChild(int i) {
      dockerfile_single_quoted_string_child(this, i, result)
    }

    /** Gets the `i`th child of this node. */
    final F::EscapeSequence getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_single_quoted_string_child(this, _, result)
    }
  }

  /** A class representing `source_file` nodes. */
  class SourceFile extends @dockerfile_source_file, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "SourceFile" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_source_file_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() { dockerfile_source_file_child(this, _, result) }
  }

  /** A class representing `stopsignal_instruction` nodes. */
  class StopsignalInstruction extends @dockerfile_stopsignal_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "StopsignalInstruction" }

    /** Gets the `i`th child of this node. */
    final F::Expansion getChild(int i) { dockerfile_stopsignal_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::Expansion getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_stopsignal_instruction_child(this, _, result)
    }
  }

  /** A class representing `unquoted_string` nodes. */
  class UnquotedString extends @dockerfile_unquoted_string, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UnquotedString" }

    /** Gets the `i`th child of this node. */
    final F::Expansion getChild(int i) { dockerfile_unquoted_string_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::Expansion getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_unquoted_string_child(this, _, result)
    }
  }

  /** A class representing `user_instruction` nodes. */
  class UserInstruction extends @dockerfile_user_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "UserInstruction" }

    /** Gets the node corresponding to the field `group`. */
    final F::UnquotedString getGroup() { dockerfile_user_instruction_group(this, result) }

    /** Gets the node corresponding to the field `user`. */
    final F::UnquotedString getUser() { dockerfile_user_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_user_instruction_group(this, result) or
      dockerfile_user_instruction_def(this, result)
    }
  }

  /** A class representing `variable` tokens. */
  class Variable extends @dockerfile_token_variable, F::AstNode, F::Token {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "Variable" }
  }

  /** A class representing `volume_instruction` nodes. */
  class VolumeInstruction extends @dockerfile_volume_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "VolumeInstruction" }

    /** Gets the `i`th child of this node. */
    final F::AstNode getChild(int i) { dockerfile_volume_instruction_child(this, i, result) }

    /** Gets the `i`th child of this node. */
    final F::AstNode getAChild() { result = this.getChild(_) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_volume_instruction_child(this, _, result)
    }
  }

  /** A class representing `workdir_instruction` nodes. */
  class WorkdirInstruction extends @dockerfile_workdir_instruction, F::AstNode {
    /** Gets the name of the primary QL class for this element. */
    final override string getAPrimaryQlClass() { result = "WorkdirInstruction" }

    /** Gets the child of this node. */
    final F::Path getChild() { dockerfile_workdir_instruction_def(this, result) }

    /** Gets a field or child node of this node. */
    final override F::AstNode getAFieldOrChild() {
      dockerfile_workdir_instruction_def(this, result)
    }
  }

  /** Provides predicates for mapping AST nodes to their named children. */
  module PrintAst {
    /** Gets a child of `node` returned by the member predicate with the given `name`. If the predicate takes an index argument, `i` is bound to that index, otherwise `i` is `-1` (which is never a valid index). */
    F::AstNode getChild(F::AstNode node, string name, int i) {
      result = node.(AddInstruction).getChild(i) and name = "getChild"
      or
      result = node.(ArgInstruction).getDefault() and i = -1 and name = "getDefault"
      or
      result = node.(ArgInstruction).getName() and i = -1 and name = "getName"
      or
      result = node.(CmdInstruction).getChild() and i = -1 and name = "getChild"
      or
      result = node.(CopyInstruction).getChild(i) and name = "getChild"
      or
      result = node.(DoubleQuotedString).getChild(i) and name = "getChild"
      or
      result = node.(EntrypointInstruction).getChild() and i = -1 and name = "getChild"
      or
      result = node.(EnvInstruction).getChild(i) and name = "getChild"
      or
      result = node.(EnvPair).getName() and i = -1 and name = "getName"
      or
      result = node.(EnvPair).getValue() and i = -1 and name = "getValue"
      or
      result = node.(Expansion).getChild() and i = -1 and name = "getChild"
      or
      result = node.(ExposeInstruction).getChild(i) and name = "getChild"
      or
      result = node.(FromInstruction).getAs() and i = -1 and name = "getAs"
      or
      result = node.(FromInstruction).getChild(i) and name = "getChild"
      or
      result = node.(HealthcheckInstruction).getChild(i) and name = "getChild"
      or
      result = node.(HeredocBlock).getChild(i) and name = "getChild"
      or
      result = node.(ImageAlias).getChild(i) and name = "getChild"
      or
      result = node.(ImageDigest).getChild(i) and name = "getChild"
      or
      result = node.(ImageName).getChild(i) and name = "getChild"
      or
      result = node.(ImageSpec).getDigest() and i = -1 and name = "getDigest"
      or
      result = node.(ImageSpec).getName() and i = -1 and name = "getName"
      or
      result = node.(ImageSpec).getTag() and i = -1 and name = "getTag"
      or
      result = node.(ImageTag).getChild(i) and name = "getChild"
      or
      result = node.(JsonString).getChild(i) and name = "getChild"
      or
      result = node.(JsonStringArray).getChild(i) and name = "getChild"
      or
      result = node.(LabelInstruction).getChild(i) and name = "getChild"
      or
      result = node.(LabelPair).getKey() and i = -1 and name = "getKey"
      or
      result = node.(LabelPair).getValue() and i = -1 and name = "getValue"
      or
      result = node.(MountParam).getValue(i) and name = "getValue"
      or
      result = node.(OnbuildInstruction).getChild() and i = -1 and name = "getChild"
      or
      result = node.(Path).getChild(i) and name = "getChild"
      or
      result = node.(RunInstruction).getChild(i) and name = "getChild"
      or
      result = node.(ShellCommand).getChild(i) and name = "getChild"
      or
      result = node.(ShellFragment).getChild(i) and name = "getChild"
      or
      result = node.(ShellInstruction).getChild() and i = -1 and name = "getChild"
      or
      result = node.(SingleQuotedString).getChild(i) and name = "getChild"
      or
      result = node.(SourceFile).getChild(i) and name = "getChild"
      or
      result = node.(StopsignalInstruction).getChild(i) and name = "getChild"
      or
      result = node.(UnquotedString).getChild(i) and name = "getChild"
      or
      result = node.(UserInstruction).getGroup() and i = -1 and name = "getGroup"
      or
      result = node.(UserInstruction).getUser() and i = -1 and name = "getUser"
      or
      result = node.(VolumeInstruction).getChild(i) and name = "getChild"
      or
      result = node.(WorkdirInstruction).getChild() and i = -1 and name = "getChild"
    }
  }
}

module DOCKERFILEFinal {
  private module F = DOCKERFILE;

  import F

  final class AstNode = F::AstNode;

  final class Token = F::Token;

  final class ReservedWord = F::ReservedWord;

  final class AddInstruction = F::AddInstruction;

  final class ArgInstruction = F::ArgInstruction;

  final class CmdInstruction = F::CmdInstruction;

  final class Comment = F::Comment;

  final class CopyInstruction = F::CopyInstruction;

  final class CrossBuildInstruction = F::CrossBuildInstruction;

  final class DoubleQuotedString = F::DoubleQuotedString;

  final class EntrypointInstruction = F::EntrypointInstruction;

  final class EnvInstruction = F::EnvInstruction;

  final class EnvPair = F::EnvPair;

  final class EscapeSequence = F::EscapeSequence;

  final class Expansion = F::Expansion;

  final class ExposeInstruction = F::ExposeInstruction;

  final class ExposePort = F::ExposePort;

  final class FromInstruction = F::FromInstruction;

  final class HealthcheckInstruction = F::HealthcheckInstruction;

  final class HeredocBlock = F::HeredocBlock;

  final class HeredocEnd = F::HeredocEnd;

  final class HeredocLine = F::HeredocLine;

  final class HeredocMarker = F::HeredocMarker;

  final class ImageAlias = F::ImageAlias;

  final class ImageDigest = F::ImageDigest;

  final class ImageName = F::ImageName;

  final class ImageSpec = F::ImageSpec;

  final class ImageTag = F::ImageTag;

  final class JsonString = F::JsonString;

  final class JsonStringArray = F::JsonStringArray;

  final class LabelInstruction = F::LabelInstruction;

  final class LabelPair = F::LabelPair;

  final class LineContinuation = F::LineContinuation;

  final class MaintainerInstruction = F::MaintainerInstruction;

  final class MountParam = F::MountParam;

  final class MountParamParam = F::MountParamParam;

  final class OnbuildInstruction = F::OnbuildInstruction;

  final class Param = F::Param;

  final class Path = F::Path;

  final class RunInstruction = F::RunInstruction;

  final class ShellCommand = F::ShellCommand;

  final class ShellFragment = F::ShellFragment;

  final class ShellInstruction = F::ShellInstruction;

  final class SingleQuotedString = F::SingleQuotedString;

  final class SourceFile = F::SourceFile;

  final class StopsignalInstruction = F::StopsignalInstruction;

  final class UnquotedString = F::UnquotedString;

  final class UserInstruction = F::UserInstruction;

  final class Variable = F::Variable;

  final class VolumeInstruction = F::VolumeInstruction;

  final class WorkdirInstruction = F::WorkdirInstruction;
}
