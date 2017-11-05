defmodule Chapter10.EnumTest do
  use ExUnit.Case

  @list [1, 2, 3, 4, 5]

  test "convert any collection into a @list" do
    assert (Enum.to_list 1..5) == [1, 2, 3, 4, 5]
  end

  test "concatenate collections" do
    assert Enum.concat([1, 2, 3], [4, 5, 6]) == [1, 2, 3, 4, 5, 6]
  end

  test "create collections whose elements are some function of the original" do
    assert Enum.map(@list, &(&1 * 10)) == [10, 20, 30, 40, 50]
    assert Enum.map(@list, &String.duplicate("*", &1)) == ["*", "**", "***", "****", "*****"]
  end

  test "select elements by position or criteria" do
    assert Enum.at(10..20, 3) == 13
    assert Enum.at(10..20, 20) == nil
    assert Enum.at(10..20, 20, :no_one_here) == :no_one_here
  end

  test "filter a list" do
    assert Enum.filter(@list, &(&1 > 2)) == [3, 4, 5]
    require Integer # to get access to is_even nil
    assert Enum.filter(@list, &Integer.is_even/1) == [2, 4]
    assert Enum.reject(@list, &Integer.is_even/1) == [1, 3, 5]
  end

  test "sort and compare elements" do
    list = ["there", "was", "a", "crooked", "man"]
    assert Enum.sort(list) == ["a", "crooked", "man", "there", "was"]
    assert Enum.sort(list, &(String.length(&1) <= String.length(&2))) == ["a", "was", "man", "there", "crooked"]
    assert Enum.max(list) == "was"
    assert Enum.max_by(list, &String.length/1) == "crooked"
  end

  test "split a collection" do
    assert Enum.take(@list, 3) == [1, 2, 3]
    assert Enum.take_every(@list, 2) == [1, 3, 5]
    assert Enum.take_while(@list, &(&1 < 4)) == [1, 2, 3]
    assert Enum.split(@list, 3) == {[1, 2, 3], [4, 5]}
    assert Enum.split_while(@list, &(&1 < 4)) == {[1, 2, 3], [4, 5]}
  end

  test "join a collection" do
    assert Enum.join(@list) == "12345"
    assert Enum.join(@list, ", ") == "1, 2, 3, 4, 5"
  end

  test "predicate operations" do
    assert Enum.all?(@list, &(&1 < 4)) == false
    assert Enum.any?(@list, &(&1 < 4)) == true
    assert Enum.member?(@list, 4) == true
    assert Enum.empty?(@list) == false
  end

  test "merge collections" do
    assert Enum.zip(@list, [:a, :b, :c]) == [{1, :a}, {2, :b}, {3, :c}]
    assert Enum.with_index(["once", "upon", "a", "time"]) == [{"once", 0}, {"upon", 1}, {"a", 2}, {"time", 3}]
  end

  test "fold elements into a single value" do
    assert Enum.reduce(1..100, &(&1 + &2)) == 5050
    assert Enum.reduce(
             ["now", "is", "the", "time"],
             fn (word, longest) ->
               if String.length(longest) < String.length(word) do
                 word
               else
                 longest
               end
             end
           ) == "time"
    assert Enum.reduce(
             ["now", "is", "the", "time"],
             0,
             fn word, longest ->
               if String.length(word) > longest,
                  do: String.length(word),
                  else: longest
             end
           ) == 4
  end

  test "deal a hand of cards" do
    import Enum
    deck = for rank <- '23456789TJQKA', suit <- 'CDHS', do: [suit,rank]
    hand_1 = deck |> shuffle |> take(13)
    hand_2 = deck |> shuffle |> take(13)
    assert hand_1 != hand_2
  end

end