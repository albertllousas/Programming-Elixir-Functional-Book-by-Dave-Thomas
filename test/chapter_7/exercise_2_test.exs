defmodule Chapter7.Exercise2Test do
  use ExUnit.Case
  @moduledoc """

  Write a max(list) that returns the element with the maximum value in the list.
  (This is slightly trickier than it sounds.)

  """

  defmodule List do
    def max([head | tail]), do: _max(tail, head)
    defp _max([], max), do: max
    defp _max([head | tail], max) when head < max, do: _max(tail, max)
    defp _max([head | tail], max), do: _max(tail, head)
  end

  test "a function that find the max on a list" do
    assert List.max([9,10,3,4,5,6]) == 10
  end
end