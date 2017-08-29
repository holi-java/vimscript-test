let s:tc = unittest#testcase#new("test/test_numbers.vim")

function! s:tc.test_hexadecimal()
  call self.assert_equal(15, 0xF)
endfunction

function! s:tc.test_octal()
  call self.assert_equal(9, 011)
endfunction

function! s:tc.test_binary()
  call self.assert_equal(3, 0b11)
endfunction
