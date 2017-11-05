defmodule Chapter6.Exercise6Test do
  use ExUnit.Case
  @moduledoc """

  I’m thinking of a number between 1 and 1000....
  The most efficient way to find the number is to guess halfway between the low and high numbers of the range.
  If our guess is too big, then theanswer lies between the bottom of the range and one less than our guess.
  If our guess is too small, then the answer lies between one more than our guess and the end of the range.
  Your API will be guess(actual, range), where range is an Elixir range.

  Your output should look similar to this:

    iex> Chop.guess(273, 1..1000)
    Is it 500
    Is it 250
    Is it 375
    Is it 312
    Is it 281
    Is it 265
    Is it 273
    273

  Hints:

  – You may need to implement helper functions with an additional parameter (the currently guessed number).
  – The div(a,b) function performs integer division.
  – Guard clauses are your friends.
  – Patterns can match the low and high parts of a range (a..b=4..8).

  """

  defmodule Chop do

    def middle(min, max), do: div(min + max, 2)

    def guess(secret, rangeMin..rangeMax) when div(rangeMin + rangeMax, 2) > secret do
      IO.puts "It is #{middle(rangeMin, rangeMax)}"
      guess(secret, rangeMin..middle(rangeMin, rangeMax))
    end

    def guess(secret, rangeMin..rangeMax) when div(rangeMin + rangeMax, 2) < secret do
      IO.puts "It is #{middle(rangeMin, rangeMax)}"
      guess(secret, middle(rangeMin, rangeMax)..rangeMax)
    end

    def guess(secret, rangeMin..rangeMax), do: IO.puts middle(rangeMin, rangeMax)

  end

  test "Guess 273 beetwen 1 and 1000" do
    import ExUnit.CaptureIO
    execute = fn -> Chop.guess(273, 1..1000) end
    assert capture_io(execute) == "It is 500\nIt is 250\nIt is 375\nIt is 312\nIt is 281\nIt is 265\n273\n"
  end

end