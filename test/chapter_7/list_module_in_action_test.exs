defmodule Chapter7.ListModuleInAction do
  use ExUnit.Case
  @moduledoc """

  The List module provides a set of functions that operate on lists.

  https://hexdocs.pm/elixir/List.html

  """
  test "list concatenation with operator '++'" do
    assert [1, 2] ++ [3, 4] == [1, 2, 3, 4]
  end

  test "flatten nested list" do
    assert List.flatten([[[1], 2], [[[3]]]]) == [1, 2, 3]
  end

  test "folding a list in both directions" do
    assert List.foldl([1, 2, 3], "", fn value, acc -> "#{value}(#{acc})" end) == "3(2(1()))"
    assert List.foldr([1, 2, 3], "", fn value, acc -> "#{value}(#{acc})" end) == "1(2(3()))"
  end

  test "updating a list in the middle (not a cheap operation)" do
    list = [1, 2, 3]
    assert List.replace_at(list, 2, "buckle my shoe") == [1, 2, "buckle my shoe"]
  end

  test "accessing tuples within lists 'keyfind(list, key, position, default \\ nil)'" do
    kw = [{:name, "Dave"}, {:likes, "Programming"}, {:where, "Dallas", "TX"}]

    assert List.keyfind(kw, "Dallas", 1) == {:where, "Dallas", "TX"}
    assert List.keyfind(kw, "TX", 2) == {:where, "Dallas", "TX"}
    assert List.keyfind(kw, "TX", 1) == nil
    assert List.keyfind(kw, "TX", 1, "No city called TX") == "No city called TX"
  end


end