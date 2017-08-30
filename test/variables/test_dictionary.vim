let s:tc = unittest#testcase#new("test/test_dictionary.vim")

fun s:tc.test_dictionary_key_is_always_string()
  let dic = {1: 'one', 2: 'two'}

  call self.assert_equal(["1", "2"], sort(keys(dic)))
endfun

fun s:tc.test_dictionary_is_empty()
  call self.assert(empty({}))
  call self.assert_not(empty({1: 2}))
endfun

fun s:tc.test_access_dictionary_entries()
  let dic = {}
  let dic[1] = "one"

  call self.assert_equal("one", dic.1)
  call self.assert_equal("one", dic[1])
  call self.assert_equal("one", dic["1"])
  call self.assert_equal({1: "one"}, dic)
endfun

fun s:tc.test_get_dictionary_values()
  let dic = {1: "one", 2: "two"}
  let entries = []

  for key in keys(dic)
    call add(entries, dic[key])
  endfor

  call self.assert_equal(sort(entries), sort(values(dic)))
endfun

fun s:tc.test_get_dictionary_entries()
  let dic = {1: "one", 2: "two"}

  call self.assert_equal(sort([["1", "one"], ["2", "two"]]), sort(items(dic)))
endfun

fun s:tc.test_copy_dictionary()
  let dic = {1: {2: "foo"}, 3: "bar"}
  let [shallow, deep] = [copy(dic), deepcopy(dic)]

  let dic[3] = "baz"
  call self.assert_equal({1: {2: "foo"}, 3: "baz"}, dic)
  call self.assert_equal({1: {2: "foo"}, 3: "bar"}, shallow)

  let dic[1][2] = "foz"
  call self.assert_equal({1: {2: "foz"}, 3: "baz"}, dic)
  call self.assert_equal({1: {2: "foz"}, 3: "bar"}, shallow)
  call self.assert_equal({1: {2: "foo"}, 3: "bar"}, deep)
endfun

fun s:tc.test_remove_entry_by_key()
  let dic = {1: 'one', 2: 'two'}
  
  unlet dic.1
  call self.assert_equal({2: 'two'}, dic) 
endfun

fun s:tc.test_remove_an_absent_key_throw_exception()
  let dic = {}
  
  try
    unlet dic.absent
    call self.assert(0)
  catch /Key not present.*: absent/
    call self.assert(1)
  endtry
endfun

fun s:tc.test_get_an_absent_key_throw_exception()
  let dic = {}
  
  try
    let dic.absent
    call self.assert(0)
  catch /Key not present.*: absent/
    call self.assert(1)
  endtry
endfun

fun s:tc.test_merge_2dictionaries()
  let [a, b] = [{1: 2}, {3: 4}]
  let merged = extend(a, b)

  call self.assert_equal({3: 4}, b)
  call self.assert_equal({1: 2, 3: 4}, a)
  call self.assert_equal({1: 2, 3: 4}, merged)
endfun

fun s:tc.test_filter()
  let dic = {1: 'one', 2: 'two'}
  let dic2 = {1: 'one', 2: 'two'}

  call self.assert_equal({1: 'one'}, filter(dic, "v:val =~ 'n'"))
  call self.assert_equal({1: 'one'}, dic)
  call self.assert_equal({2: 'two'}, filter(dic2, "v:key =~ 2"))
endfun

fun s:tc.test_define_function_with_dic_attribute()
  fun s:size() dict
    return len(self.data)
  endfun

  let dic = {'data': [1, 2, 3, 4], 'dataSize': function('s:size')}

  fun dic.size()
    return len(self)
  endfun

  call self.assert_equal(4, dic.dataSize())
  call self.assert_equal(3, dic.size())
endfun

fun s:tc.test_check_dic_has_key()
  let dic = {1: 'one', 2: 'two'}

  call self.assert(has_key(dic, 1))
  call self.assert_not(has_key(dic, "absent"))
endfun

fun s:tc.test_get_max_value()
  let dic = {5: 3, 4: 2}

  call self.assert_equal(3, max(dic))
endfun

fun s:tc.test_get_min_value()
  let dic = {5: 3, 4: 2}

  call self.assert_equal(2, min(dic))
endfun

fun s:tc.test_count_of_items_appears()
  let dic = {5: 3, 4: 2, 3: 2, 1: [2, 2]}

  call self.assert_equal(2, count(dic, 2))
endfun

fun s:tc.test_can_not_put_duplicate_keys()
  call self.assert_throw('Duplicate key.*: "1"', "let dic = {1: 2, 1: 3}")
endfun

fun s:tc.test_map_dictionary_values()
  let dic = {1: 'one', 2: 'two'}
  let dic2 = {1: 'one', 2: 'two'}

  call self.assert_equal({1: 2, 2: 3}, map(dic, 'v:key + 1'))
  call self.assert_equal({1: 2, 2: 3}, dic)
  call self.assert_equal({1: "ONE", 2: "TWO"}, map(dic2, 'toupper(v:val)'))
endfun

fun s:tc.test_to_string()
  let dic = {1: 'one', 2: 'two'}

  call self.assert_equal("{'1': 'one', '2': 'two'}", string(dic))
endfun
