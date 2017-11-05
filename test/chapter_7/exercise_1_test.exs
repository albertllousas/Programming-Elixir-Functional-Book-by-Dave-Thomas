defmodule Chapter7.Exercise1Test do
  use ExUnit.Case
  @moduledoc """

  Write a mapsum function that takes a list and a function.
  It applies the function to each element of the list and then sums the result, so

  iex> MyList.mapsum [1, 2, 3], &(&1 * &1) 14

  """

  defmodule List do
    def mapsum(list, func), do: _mapsum(list, func, 0)
    defp _mapsum([], _, acc), do: acc
    defp _mapsum([head | tail], func, acc), do: _mapsum(tail, func, acc + func.(head))
  end

  test "a mapsum function that takes a list and a function, applies the function to each element of the list
        and then sums the result" do
    assert List.mapsum([1,2,3],&(&1 * &1)) == 14
  end

end