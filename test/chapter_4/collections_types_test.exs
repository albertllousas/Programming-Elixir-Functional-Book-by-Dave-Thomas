defmodule Chapter4.CollectionsTypesTest do
  use ExUnit.Case

  test "tuples are written between braces, separating the elements with commas" do
    assert is_tuple {1, 2}
  end

  test "tuples can hold any value" do
    assert is_tuple {:ok, 42, "next"}
  end

  test "tuple elements are accessed using 'elem' function" do
    assert elem({1, 2}, 0) == 1
  end

  test "tuple size is calculated using 'tuple_size' function" do
    assert tuple_size({1, 2, 3}) == 3
  end

  test "lists are written between squares, separating the elements with commas" do
    assert is_list([1, 2])
  end

  test "lists elements are accessed by index using 'Enum.at' method" do
    assert Enum.at([1, 2], 0) == 1
  end

  test "list head is accessec using 'hd' method " do
    assert hd([1, 2]) == 1
  end

  test "list tail is accessec using 'tl' method " do
    assert tl([1, 2]) == [2]
  end

  test "list are concatenated using '++' operator" do
    assert [1] ++ [2] == [1, 2]
  end

  test "list are differenced using '--' operator" do
    assert [1, 2] -- [1] == [2]
  end

  test "list membershid is calculated using 'in' operator" do
    assert 1 in [1, 2, 3, 4] == true
  end

  test "elixir give a shorcut to write lists of two-value tuples" do
    assert [a: 1, b: 2] == [{:a, 1}, {:b, 2}]
  end

end