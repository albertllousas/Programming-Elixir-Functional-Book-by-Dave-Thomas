defmodule Chapter6.Exercise5Test do
  use ExUnit.Case
  @moduledoc """

  Write a function gcd(x,y) that finds the greatest common divisor between two nonnegative integers.
  Algebraically, gcd(x,y) is x if y is zero; it’s gcd(y, rem(x,y)) otherwise.

  """

  def gdc(x, 0), do: x
  def gdc(x, y), do: gdc(y, rem(x,y))

  test "module 'SumFromOne' calculate the sum of the integers from 1 to n" do
    assert gdc(9,12) == 3
    assert gdc(8,24) == 8
  end

end