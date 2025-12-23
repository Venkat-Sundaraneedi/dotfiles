(module
  "module" @keyword)

(line_comment) @comment

(function_decl
  name: (identifier) @function)

(byte_string) @string

(number) @number

(use_decl
  "use" @keyword.directive)

(primitive_type) @type.builtin

(bool_literal) @boolean

(type_param
  type: (identifier) @type.parameter)

(field_annot
  field: (identifier) @variable.member)

(function_decl
  "fun" @keyword.function)

(constant_decl
  "const" @keyword.declaration)

(struct_decl
  "struct" @keyword.declaration)

(enum_decl
  "enum" @keyword.declaration)

(if_expr
  "if" @keyword.conditional)

(if_expr
  "else" @keyword.conditional)

(while_expr
  "while" @keyword.repeat)

(loop_expr
  "loop" @keyword.repeat)

(binary_operator) @operator

(return_expr
  "return") @keyword.return

(abort_expr
  "abort") @keyword.control

(move_expr
  "move") @keyword.control

(copy_expr
  "copy") @keyword.control

(let_expr
  "let") @keyword.declaration

(for_loop_expr
  "for") @keyword.repeat

(match_expr
  "match") @keyword.conditional

(spec_block
  "spec") @keyword.directive

(module_member_modifier
  "entry") @keyword.modifier

(module_member_modifier
  "native") @keyword.modifier

(visibility
  "public") @keyword.modifier

(visibility
  "package") @keyword.modifier

(visibility
  "friend") @keyword.modifier

(cast_expr
  "as") @keyword.operator

(is_type_expr
  "is") @keyword.operator

(not_expr
  "!") @operator

(ref_mut_expr
  "&mut") @operator

(ref_expr
  "&") @operator

(deref_expr
  "*") @operator

(name_access_chain
  "::") @operator

(block_comment) @comment

(address_block
  "address") @keyword.directive

(script
  "script") @keyword.directive

(var) @variable

(numerical_addr) @constant.builtin

(call_expr
  func_name: (name_access_chain) @function.call)

(receiver_call
  func: (identifier) @function.call)

(macro_call_expr
  macro_name: (name_access_chain) @function.macro)

(expr_field
  field: (identifier) @variable.member)

(parameter
  variable: (identifier) @variable.parameter)

(bind_field
  field: (var_name) @variable.member)

"=" @operator.assignment

"+=" @operator.assignment

"-=" @operator.assignment

"*=" @operator.assignment

"/=" @operator.assignment

"%=" @operator.assignment

([
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "<"
  ">"
]) @punctuation.bracket

([
  ","
  ";"
  ":"
  "."
  "|"
  "=>"
]) @punctuation.delimiter

(attributes
  "#") @attribute

(spec_func
  "fun") @keyword.function

(spec_func
  "native") @keyword.modifier

(condition_props
  "[") @punctuation.bracket

(condition_props
  "]") @punctuation.bracket

(spec_let
  "let") @keyword.declaration

(type
  (name_access_chain
    name: (identifier) @type))
