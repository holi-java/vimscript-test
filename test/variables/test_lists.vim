let s:tc = unittest#testcase#new("test/test_lists.vim", unittest#assertions#__context__())

fun s:tc.test_create_nested_list()
  let list = [1, [2, 3]]

  call self.assert_equal(1, list[0])
  call self.assert_equal([2, 3], list[1])
  call self.assert_equal(3, list[1][1])
endfun

fun s:tc.test_get_item_from_list()
  let list = [1, 2, 3]
  
  call self.assert_equal(1, list[0])
  call self.assert_equal(0, get(list, 3)) 
  call self.assert_equal(-1, get(list, 3, -1)) 

  call self.set("s:list", list)
  call self.assert_throw("list index out of range: 3", "echo s:list[3]")
endfun

fun s:tc.test_union_lists()
  let union = [1, 2] + [3, 4]

  call self.assert_equal([1, 2, 3, 4], union)

  let union += [5]
  call self.assert_equal([1, 2, 3, 4, 5], union)
endfun

fun s:tc.test_subList()
  let list = [1, 2, 3, 4] 

  call self.assert_equal([3, 4], list[2:-1])
  call self.assert_equal([3, 4], list[2:])
  call self.assert_equal([3, 4], list[2:100])
  call self.assert_equal([1, 2, 3, 4], list[:])
  call self.assert_equal([4], list[-1:])
  call self.assert_equal([2, 3, 4], list[-3:])
endfun

fun s:tc.test_subList_range_conflicts()
  let list = [1, 2, 3, 4] 
  let s=1
  let e=2
  let s:e = 3 

  call self.assert_equal(4, list[s:e])
  call self.assert_equal([2, 3], list[s : e])
endfun

fun s:tc.test_list_identity()
  let a = [1, 2]
  let b = a
  let c = a[:]

  let a += [3]

  call self.assert_equal([1, 2, 3], b)
  call self.assert_equal([1, 2], c)
endfun

fun s:tc.test_unpack_list()
  let list = [1, 2, 3, 4]
  let [first, second; rest] = list

  call self.assert_equal(1, first)
  call self.assert_equal(2, second)
  call self.assert_equal([3, 4], rest)
endfun

fun s:tc.test_unpack_list_with_no_enough_args()
  let list = [1, 2]
  let [first, second; rest] = list

  call self.assert_equal(1, first)
  call self.assert_equal(2, second)
  call self.assert_equal([], rest)
endfun

fun s:tc.test_set_item_in_list()
  let list = [1, 2]

  let list[0] = -1

  call self.assert_equal([-1, 2], list)
endfun

fun s:tc.test_check_list_is_empty()
  call self.assert(empty([]))
  call self.assert_not(empty([1]))
endfun

fun s:tc.test_get_list_size()
  call self.assert_equal(0, len([]))
  call self.assert_equal(2, len(["foo", "bar"]))
endfun

fun s:tc.test_get_max_value_in_list()
  call self.assert_equal(4, max([3, 4, 1]))
endfun

fun s:tc.test_get_min_value_in_list()
  call self.assert_equal(1, min([3, 4, 1]))
endfun

fun s:tc.test_get_item_appearances()
  let items = [1, 3, 3, 3, 3, 3]

  call self.assert_equal(1, count(items, 1))
  call self.assert_equal(5, count(items, 3))
endfun

fun s:tc.test_get_item_index()
  let items = [1, 3, 3, 3, 3, 3]

  call self.assert_equal(0, index(items, 1))
  call self.assert_equal(1, index(items, 3))
  call self.assert_equal(-1, index(items, 2))
endfun

fun s:tc.test_split_string_to_list()
  let lines = split(" one two ")

  call self.assert_equal(['one', 'two'], lines)
endfun

fun s:tc.test_join_list_to_string()
  let string = join(['one', 'two'], ", ")

  call self.assert_equal("one, two", string)
endfun

fun s:tc.test_list_to_string()
  let string = string(['one', 'two'])

  call self.assert_equal("['one', 'two']", string)
endfun

fun s:tc.test_map_list()
  let list = map(['one', 'two'], '"> " . v:val')

  call self.assert_equal(["> one", "> two"], list)
endfun



