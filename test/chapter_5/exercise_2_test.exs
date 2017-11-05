defmodule Chapter5.Exercise2Test do
  use ExUnit.Case
  @moduledoc """

  Write a function that takes three arguments.
  - If the first two are zero, return “FizzBuzz.”
  - If the first is zero, return “Fizz.”
  - If the second is zero, return “Buzz.”
  - Otherwise return the third argument.

  """
  def create_fizz_buzz, do:
    fn
      0, 0, _ -> "FizzBuzz"
      0, _, _ -> "Fizz."
      _, 0, _ -> "Buzz."
      _, _, c -> c
    end


  test "If the first two are zero, return “FizzBuzz" do
    assert create_fizz_buzz().(0,0,3) == "FizzBuzz"
  end

  test "If the first is zero, return “Fizz." do
    assert create_fizz_buzz().(0,1,3) == "Fizz."
  end

  test "If the second is zero, return “Buzz." do
    assert create_fizz_buzz().(1,0,3) == "Buzz."
  end

  test "Otherwise return the third argument." do
    assert create_fizz_buzz().(1,1,3) == 3
  end
end