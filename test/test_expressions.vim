let s:tc = unittest#testcase#new("test/test_expressions.vim", unittest#assertions#__context__())

fun s:tc.test_ternay_expression()
  let foo = "bar"
  let null = v:null

  call self.assert_equal("bar", foo == null ? null : foo)
  call self.assert_equal("baz", foo == "bar" ? "baz" : foo)
endfun

fun s:tc.test_logic_operator_will_be_short_circuited()
  fun s:fail()
    throw "error"
  endfun
  call self.set("s:fail", function("s:fail"))
  call self.assert_throw("error", "call s:fail()")

  call self.assert(v:true || s:fail())
  call self.assert_not(v:false && s:fail())
endfun

fun s:tc.test_comparison()
  call self.assert(1 < 2)
  call self.assert(2 == 2)
  call self.assert(2 ==? 2)
  call self.assert(2 ==# 2)
  call self.assert(2 =~ 2)
  call self.assert_not(2 < 2)
  call self.assert(2 <= 2)
  call self.assert_not(2 > 2)
  call self.assert(2 >= 2)
endfun

fun s:tc.test_regex_matches()
  call self.assert("foo" =~ "f")
  call self.assert("foo" =~ "oo")
  call self.assert_not("oo" =~ "foo")
  call self.assert_not("foo" =~ "FOO")
endfun

fun s:tc.test_regex_does_not_matches()
  call self.assert_not("foo" !~ "f")
  call self.assert_not("foo" !~ "oo")
  call self.assert("foo" !~ "FOO")
endfun

fun s:tc.test_equal_ignore_case()
  call self.assert("foo" ==? "foo")
  call self.assert("foo" ==? "FOO")
  call self.assert_not("foo" ==? "f")
endfun

fun s:tc.test_same_instance()
  let foo = [1, 2, 3]
  let bar = [1, 2, 3]

  call self.assert(foo is foo)
  call self.assert(foo isnot bar)
endfun

fun s:tc.test_plus_2numbers()
  let one = "1"

  call self.assert_is_String(one)
  call self.assert_equal(3, one + 2)

  call self.assert_equal(3, 1 + 2)
  call self.assert_equal(3.0, 1 + 2.0)
endfun

fun s:tc.test_plus_2lists()
  call self.assert_equal([1, 2, 3], [1, 2] + [3])
endfun

fun s:tc.test_concat_2strings()
  call self.assert_equal("football", "foot"."ball")
endfun

fun s:tc.test_substring()
  call self.assert_equal("ball", "football"[4:])
  call self.assert_equal("ball", "football"[4:-1])
endfun

fun s:tc.test_lambda_expression()
  let s:square = {n -> 2*n}
  call self.assert_equal(6, s:square(3))
endfun

fun s:tc.test_risk_of_dot_mark()
  let string = 1 . 90
  let decimal = 1.90

  call self.assert_equal("190", string)
  call self.assert_equal(1.9, decimal)
endfun

fun s:tc.test_risk_of_colon_mark()
  let list = [1, 2, 3]
  let [s, e, s:e] = [1, -1, 0]

  call self.assert_equal(1, list[s:e])
  call self.assert_equal([2, 3], list[s : e])
endfun

fun s:tc.test_divide_by_0()
  call self.assert_not(isnan(0/0))
  call self.assert_match('\v^80+$', printf('%x', 0/0))
  call self.assert_match('\v^7f+$', printf('%x', 1/0))
  call self.assert_match('\v^80+1$', printf('%x', -1/0))
endfun
