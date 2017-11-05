defmodule Chapter6.Exercise4Test do
  use ExUnit.Case
  @moduledoc """

  Implement function sum(n) that uses recursion to calculate the sum of the integers from 1 to n.

  """

  def sum(1), do: 1
  def sum(n), do: n + sum(n - 1)


  test "sum function calculates the sum of the integers from 1 to n" do
    assert sum(2) == 3
    assert sum(5) == 15
  end

end