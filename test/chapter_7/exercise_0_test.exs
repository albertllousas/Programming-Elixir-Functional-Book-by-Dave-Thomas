defmodule Chapter7.Exercise0Test do
  use ExUnit.Case
  @moduledoc """

  I defined our sum function to carry a partial total as a second parameter so
  I could illustrate how to use accumulators to build values.
  The sum function can also be written without an accumulator.

  Can you do it?

  """

  defmodule List do
    def sum([]), do: 0
    def sum([ head | tail ]), do: head + sum(tail)
  end

  test "function that sum all the values of a list without an accumulator passed as argument" do
    assert List.sum([1,2,3,4]) == 10
  end
end