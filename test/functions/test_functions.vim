let s:tc = unittest#testcase#new("test/functions/test_functions.vim", unittest#assertions#__context__())
if(filereadable("stubs.vim"))
  source stubs.vim
else
  source test/functions/stubs.vim
endif

fun! s:tc.test_call_function_from_included_script()
   call self.assert(Touch()) 
endfun

fun! s:tc.test_access_variables_from_included_script()
  call self.assert_exists("g:global_scope")
  call self.assert_equal("global", g:global_scope)
  call self.assert_not_exists("s:script_scope")
  call self.assert_not_exists("v:vim_script")
  call self.assert_not_exists("w:vim_script")
endfun

fun! s:tc.test_define_function_in_dictionary_entry()
  let dict = {'data': ["one", "two"]}

  fun! dict.first()
    return self.data[0]
  endfun

  call self.assert_equal("one", dict.first())
endfun

fun! s:tc.test_define_function_ref_in_dictionary_entry()
  let key = "data"
  let dict = {key: ["one", "two"]}
  fun! s:key() closure
    return key
  endfun

  fun! s:data() closure
    return self[key]
  endfun

  let dict.key = function("s:key")
  let dict.all = function("s:data")
  call self.set("s:dict", dict)

  call self.assert_equal(key, dict.key())
  call self.assert_not_equal(dict, dict.all())
endfun

fun! s:tc.test_define_dict_function()
  let key = "data"
  let dict = {key: ["one", "two"]}
  fun! s:first() dict closure
    return self[key][0]
  endfun

  let dict.first = function("s:first")

  call self.assert_equal("one", dict.first())
endfun

fun! s:tc.test_define_closure_function_to_access_variables_and_varguments_from_the_outer_scope()
  fun! s:square(a)
    let b = 2

    fun! s:cal() closure
      return a:a * b
    endfun

    return s:cal()
  endfun

  call self.assert_equal(6, s:square(3))
endfun

fun! s:tc.test_ranged_function()
  let result=[-1, -1]

  fun! s:range(result) range
    let a:result[0]=a:firstline
    let a:result[1]=a:lastline
  endfun


  :1,$call s:range(result)

  call self.assert_equal([1, line("$")], result)
endfun

fun! s:tc.test_varargs()
  fun! s:args(first, ...)
    return [a:first, a:0, exists("a:1") ? a:{1} : -1, exists("a:2") ? a:{2} : -1, a:000]
  endfun

  call self.assert_equal([4, 0, -1, -1, []], s:args(4))
  call self.assert_equal([4, 1,  5, -1, [5]], s:args(4, 5))
  call self.assert_equal([4, 2,  5,  6, [5, 6]], s:args(4, 5, 6))
endfun

fun! s:tc.test_get_all_args()
  fun! s:args(first, ...)
    let args = [a:first]
    let i = 0 
    while(a:0 > i)
      call add(args, a:{i+1})
      let i += 1
    endwhile
    return args
  endfun

  call self.assert_equal([4], s:args(4))
  call self.assert_equal([4, 5], s:args(4, 5))
  call self.assert_equal([4, 5, 6], s:args(4, 5, 6))
endfun


fun! s:tc.test_args_cannot_be_changed()
  fun! s:args(first)
    let a:first = 1
  endfun

  try
    call s:args(1)
    call self.assert(v:false)
  catch 
    call self.assert_is_String(v:exception)
    call self.assert_match('read-only variable "a:first"', v:exception)
  endtry
endfun

fun! s:tc.test_delete_functions()
  fun! s:test()
  endfun

  call self.assert(exists("*s:test"))

  delfun s:test
  call self.assert_not(exists("*s:test"))
endfun

fun! s:tc.test_delete_dict_functions()
  let dict = {}
  fun! dict.test()
  endfun

  call self.assert(exists("*dict.test"))
  call self.assert_equal(1, len(dict))

  delfun dict.test
  call self.assert_not(exists("*dict.test"))
  call self.assert_equal(0, len(dict))
endfun

fun! s:tc.test_default_value0()
  fun! s:test()
  endfun

  call self.assert_equal(0, s:test())
endfun
