let s:tc = unittest#testcase#new("test_start.vim")

function! s:tc.test_assert_boolean()
  call self.assert(1)
  call self.assert_not(0)
endfunction

function! s:tc.test_assert_equal()
  call self.assert_equal("foo", "foo")
  call self.assert_not_equal("FOO", "foo")
endfunction

function! s:tc.test_assert_equal_ignore_case()
  call self.assert_equal_c("foo", "foo")
  call self.assert_equal_c("FOO", "foo")
  call self.assert_equal_q("foo", "foo")
  call self.assert_equal_q("FOO", "foo")

  call self.assert_not_equal_c("foo", "bar")
endfunction

function! s:tc.test_assert_equal_match_case()
  call self.assert_equal_C("foo", "foo")
  call self.assert_equal_s("foo", "foo")

  call self.assert_not_equal_C("Foo", "foo")
  call self.assert_not_equal_s("Foo", "foo")
endfunction

function! s:tc.test_assert_is_same_instance()
  call self.assert_is(v:t_number, type(1))
  call self.assert_is_not(v:t_number, type(1.2))
endfunction

function! s:tc.test_assert_is_number()
  call self.assert_is_Number(1)
endfunction

function! s:tc.test_assert_is_list()
  call self.assert_is_List([1])
  call self.assert_is(v:t_list, type([1]))
  call self.assert_is_not(v:t_list, 1)
endfunction

function! s:tc.test_assert_is_dictionary()
  call self.assert_is_Dict({})
  call self.assert_is(v:t_dict, type({}))
  call self.assert_is_not(v:t_dict, type([]))
endfunction

function! s:tc.test_assert_is_float()
  call self.assert_is_Float(1.2)
  call self.assert_is(v:t_float, type(1.2))
  call self.assert_is_not(v:t_float, type(1))
endfunction

function! s:tc.test_assert_match_with_regex_pattern()
  let pattern = "^f.*"

  call self.assert_match(pattern, "foo")
  call self.assert_not_match(pattern, "Foo")
  call self.assert_not_match(pattern, "afoo")
endfunction

function! s:tc.test_assert_match_with_regex_pattern_ignore_case()
  let pattern = "^f.*"

  call self.assert_match_c(pattern, "foo")
  call self.assert_match_c(pattern, "foo")
  call self.assert_match_q(pattern, "Foo")
  call self.assert_match_q(pattern, "Foo")

  call self.assert_not_match_c(pattern, "afoo")
  call self.assert_not_match_q(pattern, "afoo")
endfunction

function! s:tc.test_assert_throw_exception_contains_message()
  call self.assert_throw("Undefined variable: foo", "echo foo")
  " match with regex
  call self.assert_throw(".*oo", "echo foo")
  call self.assert_not_throw("echo 'foo'")
endfunction

function! s:tc.test_assert_exists_expression()
  call self.assert_exists("v:t_number")
  call self.assert_not_exists("foo")

  let foo = "bar"

  call self.assert_not_exists("foo")
endfunction

function! s:tc.test_assert_dictionary_has_key()
  let table = {"foo": "bar"}

  call self.assert_has_key("foo", table)
  call self.assert_not_has_key("bar", table)
endfunction

function! s:tc.test_assert_is_functionref()
  call self.assert_is_Funcref(function("execute"))
  call self.assert_is(v:t_func, type(function("execute")))
  call self.assert_is_not(v:t_func, type("execute"))
endfunction

function! s:tc.test_add_a_failing_test()
  call self.assert(0) //failed
endfunction
