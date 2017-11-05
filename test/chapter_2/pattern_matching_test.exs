defmodule Chapter2.PatternMarchingTest do
  use ExUnit.Case

  test "elixir make the match true by binding the variable 'a' to value 1" do
    a = 1
    assert a == 1
  end

  test "elixir make the match true by rebinding the variable a to value 2" do
    a = 1
    assert (a = 2) == 2
  end

  test "elixir not rebind the variable and raise an exception when variable is in the right side" do
    a = 1
    assert_raise MatchError, fn -> (2 = a) end
  end

  test "elixir bound the variable list to the list [1, 2, 3] to make the match true" do
    list = [1, 2, 3]
    assert list == [1, 2, 3]
  end

  test "elixir set the values on the left side to make the match true" do
    list = [1, 2, 3]
    [a, b, c] = list
    assert a == 1 and b == 2 and c == 3
  end

  test "elixir set the value on the left side to make the match true" do
    list = [1, 2, 3]
    [1, b, 3] = list
    assert b == 2
  end

  test "elixir set the values on the left side to make the match true with a complex list" do
    list = [1, 2, [3, 4, 5]]
    [a, b, c] = list
    assert a == 1 and b == 2 and c == [3, 4, 5]
  end

  test "elixir raise a match exception when it can not make the match true" do
    assert_raise MatchError, fn -> [1, a, 3] = [2, 3, 4]  end
  end

  test "elixir raise a match exception when try to match lists with diferent size" do
    assert_raise MatchError, fn -> [a, b, c] = [2, 3, 4, 5]  end
  end

  test "elixir ignore underscores when match" do
    assert [1, _, _] = [1, 2, 3]
  end

  test "once a variable has been bound to a value in the matching process, it keeps that in the current match" do
    assert_raise MatchError, fn -> [b, b] = [1, 2] end
  end

  test "a variable can be bound to a new value in a subsequent match" do
    a = 1
    [1, a, 3] = [1, 2, 3]
    assert a == 2
  end

  test "force elixir to use the existing value of the variable in the pattern" do
    a = 1
    assert_raise MatchError, fn -> ^a = 2 end
  end

end
