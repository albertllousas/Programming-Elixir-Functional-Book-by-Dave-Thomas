defmodule Chapter10.Exrecise7ListAndRecursionTest do
  use ExUnit.Case
  @moduledoc """

  In the last exercise of Chapter 7, Lists and Recursion, on page 65, you wrote a span function.
  Use it and list comprehensions to return a list of the prime numbers from 2 to n.

  """


  defmodule PrimeNumbers do
    alias Chapter7.Exercise4Test.List, as: MyList
    def from2To(n), do:
      for n <- MyList.span(2, n), Enum.all?(MyList.span(2, n - 1), &(rem(n, &1) != 0)), do: n
  end

  test "first prime number until 10" do
    assert PrimeNumbers.from2To(10) == [2, 3, 5, 7]
  end

  test "first prime number until 20" do
    assert PrimeNumbers.from2To(20) == [2, 3, 5, 7, 11, 13, 17, 19]
  end

end