let s:tc = unittest#testcase#new("test/variables/test_extras.vim")

fun s:tc.test_get_expression_type()
  call self.assert_equal(v:t_none, type(v:null))
  call self.assert_equal(v:t_number, type(0))
  call self.assert_equal(v:t_float, type(1.0))
  call self.assert_equal(v:t_bool, type(v:true))
  call self.assert_equal(type([]), type([1, 2, 3]))
endfun

fun s:tc.test_get_variable_dynamic_by_curly_braces_names()
  let barz = "baz"
  let foo = "bar"
  let name = "foo"

  call self.assert_match("bar", {name})
  call self.assert_match("bar", f{"oo"})
  call self.assert_match("baz", {{name}}z)
endfun

