defmodule Chapter3.Exercise3Test do
  use ExUnit.Case
  @moduledoc """

  The operator rem(a, b) returns the remainder after dividing a by b.
  Write a function that takes a single integer (n) and calls the function in the previous exercise,
  passing it rem(n,3), rem(n,5), and n.
  Call it seven times with the arguments 10, 11, 12, and so on.
  You should get “Buzz, 11, Fizz, 13, 14, FizzBuzz, 16.”

  """

  def create_fizz_buzz_test, do:
    fn n -> Chapter5.Exercise2Test.create_fizz_buzz().(rem(n, 3), rem(n, 5), n) end

  test "Call fn with 10, 11, 12, 13, 14, 15, 16 and get 'Buzz, 11, Fizz, 13, 14, FizzBuzz, 16.'" do
    assert Enum.map(10..16, &(create_fizz_buzz_test().(&1))) == ["Buzz.", 11, "Fizz.", 13, 14, "FizzBuzz", 16]
  end
end