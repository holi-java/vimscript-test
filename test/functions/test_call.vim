let s:tc = unittest#testcase#new("test/functions/test_call.vim")


fun! s:tc.test_call_unranged_function_Ntimes_if_a_range_was_provided()

  let n = 0
  fun! s:counter() closure
   let n += 1 
  endfun  

  fun! s:counter2() range closure
   let n += 1 
  endfun  

  call s:counter()
  call self.assert_equal(1, n)

  1,3call s:counter()
  call self.assert_equal(4, n)

  1,3call s:counter2()
  call self.assert_equal(5, n)
endfun
