let s:tc = unittest#testcase#new("test/test_floats.vim")

function! s:tc.test_floating_points_must_be_presents()
  call self.assert_not_throw("call eval('1.2')")
  call self.assert_not_throw("call eval('1.2e40')")

  call self.assert_throw("Invalid expression", "call eval('1.')")
  call self.assert_throw("Trailing characters", "call eval('1e40')")
endfunction

function! s:tc.test_floating_point_formats()
  call self.assert_equal(123.4, 1.234e2)
  call self.assert_equal(0.1234, 123.4e-3)
  call self.assert_equal(-0.1234, -123.4e-3) 
endfunction
