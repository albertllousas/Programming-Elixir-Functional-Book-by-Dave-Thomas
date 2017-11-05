defmodule Chapter7.Exercise3Test do
  use ExUnit.Case
  @moduledoc """

  An Elixir single-quoted string is actually a list of individual character codes.
  Write a caesar(list, n) function that adds n to each list element,
  wrapping if the addition results in a character greater than z.

  iex> MyList.caesar('ryvkve', 13) ?????? :)

  """

  defmodule List do
    def caesar([], _), do: []
    def caesar([head | tail], n) when head + n > 122, do: ['?' | caesar(tail, n)]
    def caesar([head | tail], n), do: [head + n | caesar(tail, n)]
  end

  test "caesar function" do
    assert List.caesar('ryvkve', 22) === ['?','?','?','?','?','?']
  end

end