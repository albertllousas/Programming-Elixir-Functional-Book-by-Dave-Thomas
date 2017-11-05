defmodule Chapter7.ListsAndRecursionTest do
  use ExUnit.Case

  test "list can be written as the head joined to tail using pipe operator (|)" do
    assert [3] == [3 | []]
    assert [1, 2] == [1 | [2 | []]]
  end

  test "using pipe in pattern matching, left of it matches the head value of the list and right matches the tail" do
    [head | tail] = [1, 2, 3]
    assert head == 1 and tail == [2, 3]
  end

  test "if all the values in a list represent printable characters, it displays the list as a string;
        otherwise it displays a list of integers." do
    assert [99, 97, 116] == 'cat'
  end

  test "use head | tail and pattern matching on named functions to calculate the length of a list (process a list)" do
    defmodule List do
      def len([]), do: 0
      def len([_head | tail]), do: 1 + len(tail)
    end
    assert List.len([1, 1, 1, 1, 1]) == 5
  end

  test "a function that takes a list of numbers and returns a new list containing the square of each.
        Using Head and Tail to Build a List" do
    defmodule List do
      def square([]), do: []
      def square([head | tail]), do: [head * head | square(tail)]
    end
    assert List.square([4, 5, 6]) == [16, 25, 36]

  end

  test "a function that adds one to every element in the integer list" do
    defmodule List do
      def add_1([]), do: []
      def add_1([head | tail]), do: [head + 1 | add_1(tail)]
    end
    assert List.add_1([1, 2, 3, 4]) == [2, 3, 4, 5]
  end

  test "a function 'map' that applies a function to all of the elements of a list and return a new one" do
    defmodule List do
      def map([], _func), do: []
      def map([head | tail], func), do: [func.(head) | map(tail, func)]
    end
    assert List.map([1, 2, 3], &(&1 + 1)) == [2, 3, 4]
  end

  test "a function that sum all the elements of a list, passing the state of the sum as a parameter" do
    defmodule List do
      def sum([], total), do: total
      def sum([head | tail], total), do: sum(tail, head + total)
    end

    assert List.sum([1, 3, 4], 0) == 8
  end

  test "a function that sum all the elements of a list, passing the state of the sum as a parameter,
        but hidding the implementation in private functions" do
    defmodule List do
      def sum(list), do: _sum(list, 0)
      def _sum([], total), do: total
      def _sum([head | tail], total), do: _sum(tail, head + total)
    end

    assert List.sum([1, 2, 3]) == 6
  end

  test "a general-purpose function that reduces a collection to a value" do
    defmodule List do
      def reduce([], _, acc), do: acc
      def reduce([head | tail], func, acc), do: reduce(tail, func, func.(head, acc))
    end

    assert List.reduce([1, 3, 4], fn (val, acc) -> val + acc end, 1) == 9
  end

  test "the join operator, |, supports multiple values to its left" do
    assert [1, 2, 3 | [4, 5, 6]] == [1, 2, 3, 4, 5, 6]
  end

  test "a function that swaps pairs of values in a list" do
    defmodule Swapper do
      def swap([]), do: []
      def swap([first, second | tail]), do: [second, first | swap(tail)]
      def swap(_), do: raise "Can't swap a list with an odd number of elements"
    end
    assert Swapper.swap([1, 2, 3, 4]) == [2, 1, 4, 3]
    assert_raise RuntimeError, fn -> Swapper.swap([1, 2, 3, 4, 5]) end
  end

  @test_data [
    [1366225622, 26, 15, 0.125],
    [1366225622, 27, 15, 0.45],
    [1366225622, 28, 21, 0.25],
    [1366229222, 26, 19, 0.081],
    [1366229222, 27, 17, 0.468],
    [1366229222, 28, 15, 0.60],
    [1366232822, 26, 22, 0.095],
    [1366232822, 27, 21, 0.05],
    [1366232822, 28, 24, 0.03],
    [1366236422, 26, 17, 0.025]
  ]

  test "given a list of recorded temperatures and rainfall at a number of weather stations as [ ts, loc_id, temp, rainfall ]
        we want to report on the conditions for one particular location, number 27" do

    defmodule WeatherHistory do
      def for_location_27([]), do: []
      def for_location_27([[timestamp, 27, temperature, rainfall] | tail]) do
        [[timestamp, 27, temperature, rainfall] | for_location_27(tail)]
      end
      def for_location_27([_ | tail]), do: for_location_27(tail)
    end

    data_for_27 = [[1366225622, 27, 15, 0.45], [1366229222, 27, 17, 0.468], [1366232822, 27, 21, 0.05]]

    assert WeatherHistory.for_location_27(@test_data) == data_for_27
  end

  test "given a list of recorded temperatures and rainfall at a number of weather stations as [ ts, loc_id, temp, rainfall ]
        we want to report on the conditions for one parametrized location" do

    defmodule WeatherHistory do
      def for_location([], _), do: []
      def for_location([head = [_, target, _, _] | tail], target) do
        [head | for_location(tail, target)]
      end
      def for_location([_ | tail], location), do: for_location(tail, location)
    end

    data_for_27 = [[1366225622, 27, 15, 0.45], [1366229222, 27, 17, 0.468], [1366232822, 27, 21, 0.05]]

    assert WeatherHistory.for_location(@test_data, 27) == data_for_27

  end

end