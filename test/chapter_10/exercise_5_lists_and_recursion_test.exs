defmodule Chapter10.Exrecise5ListAndRecursion do
  use ExUnit.Case
  @moduledoc """

  Implement the following Enum functions using no library functions or list comprehensions:

       all?, each, filter, split, and take.

  You may need to use an if statement to implement filter.

  The syntax for this is

      if condition do
        expression(s)
      else
        expression(s)
      end

  """
  defmodule MyEnum do
    @doc """
    Returns true if the given predicate evaluates to true on all of the items in the list
    """
    def all?([], predicate), do: true
    def all?([head | tail], predicate), do: if predicate.(head), do: all?(tail, predicate), else: false

    @doc """
    Invokes the given fun for each item in the enumerable
    """
    def each([], _), do: :ok
    def each([head | tail], fun) do
      fun.(head)
      each tail, fun
    end
    @doc """
    Filters the enumerable, i.e. returns only those elements for which fun returns a truthy value
    """
    def filter([], _), do: []
    def filter([head | tail], predicate),
        do: if predicate.(head), do: [head | filter(tail, predicate)], else: filter(tail, predicate)

    @doc """
    Splits the enumerable into two enumerables, leaving count elements in the first one
    """
    def split(list, count), do: _split([], list, count, 0)
    defp _split(left, right = [head | tail], count, index) when count > index,
         do: _split(left ++ [head], tail, count, index + 1)
    defp _split(left, right, _, _), do: {left, right}

    @doc """
    Takes the first count items from the enumerable
    """
    def take(list, count), do: _take([], list, count, 0)
    defp _take(result, right = [head | tail], count, index) when count > index,
         do: _take(result ++ [head], tail, count, index + 1)
    defp _take(result, _, _, _), do: result

  end

  test "all elements of a list are evaluated as true" do
    list = [1, 2, 3]
    assert MyEnum.all?(list, &(&1 < 4)) == true
  end

  test "apply a function to all elements in a list" do
    import ExUnit.CaptureIO
    list = [1, 2, 3]
    assert capture_io(fn -> MyEnum.each(list, fn elem -> IO.puts elem end) end) == "1\n2\n3\n"
  end

  test "filter a list given a predicate" do
    assert MyEnum.filter([1, 2, 3, 4], &(&1 <= 2)) == [1, 2]
    assert MyEnum.filter([1, 2, "john", 4], &(is_integer(&1))) == [1, 2, 4]
  end

  test "split a list in two given a predicate" do
    assert MyEnum.split([1, 2, 3, 4], 2) == {[1, 2], [3, 4]}
  end

  test "take the first n elements from list" do
    assert MyEnum.take([1, 2, 3, 4], 2) == [1,2]
  end

end