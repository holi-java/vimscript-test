let s:tc = unittest#testcase#new("test/test_strings.vim")

function! s:tc.test_string_octal_formats()
  call self.assert_equal("a", "\141")
  call self.assert_equal("A", "\101")
  call self.assert_equal(" ", "\40")
  call self.assert_equal("", "\0")
endfunction

function! s:tc.test_string_hex_formats()
  call self.assert_equal("a", "\x61")
  call self.assert_equal("A", "\x41")
  call self.assert_equal(" ", "\x20")
  call self.assert_equal("", "\x0")
endfunction

function! s:tc.test_string_unicode_formats()
  call self.assert_equal("ʤ", "\u02a4")
endfunction

function! s:tc.test_escape_chars()
  call self.assert_equal("\x08", "\b")
  call self.assert_equal("\x1B", "\e")
  call self.assert_equal("\x0C", "\f")
  call self.assert_equal("\x0D", "\r")
  call self.assert_equal("\x0A", "\n")
  call self.assert_equal("\x09", "\t")
  call self.assert_equal("\x5C", "\\")
  call self.assert_equal("\x22", '"')
  call self.assert_equal("\x01", "\<C-A>")
endfunction

function! s:tc.test_string_literal_do_not_need_double_backslashes()
  call self.assert_equal("\\s", '\s')
  call self.assert_equal("foo", 'foo')
endfunction

function! s:tc.test_options()
  set helplang=cn
  call self.assert_equal("cn", &helplang)
  call self.assert_equal("cn", &g:helplang)
  call self.assert_equal("cn", &l:helplang)

  let &helplang="en"

  call self.assert_equal("en", &helplang)
  call self.assert_equal("en", &g:helplang)
  call self.assert_equal("en", &l:helplang)
endfunction

