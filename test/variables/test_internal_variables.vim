let s:tc = unittest#testcase#new("test/variables/test_internal_variables.vim")

fun s:tc.test_access_global_variable_must_check_whether_is_exists_first()
  call self.assert_equal(v:false, exists("g:unknown"))
  call self.assert_throw("Undefined variable: g:unknown", "echo g:unknown")

  let g:foo = "bar"
  call self.assert_equal(v:true, exists("g:foo"))
endfun

let foo = "bar"
let s:foo = "baz"
fun s:tc.test_variable_without_scope_outside_function_will_be_treat_as_global_variable()
  let key = "value"

  call self.assert_equal("value", key)
  call self.assert_equal("value", l:key)
  call self.assert_not_exists("g:key")
  call self.assert_equal("baz", s:foo)
  call self.assert_equal("bar", g:foo)
endfun

fun s:tc.test_function_argument_variable()
  fun Tick(i)
    return a:i+1
  endfun

  call self.assert_equal(2, Tick(1))
endfun

fun s:tc.test_function_script_variable()
  let s:i = 0
  fun! Tick()
    let s:i += 1
    return s:i
  endfun

  call self.assert_equal(1, Tick())
  call self.assert_equal(2, Tick())
endfun

fun s:tc.test_function_local_variable()
  let l:i = 0
  fun! Tick()
    let l:i += 1
  endfun

  call self.assert_throw("Undefined variable: l:i", "call Tick()") 
endfun
