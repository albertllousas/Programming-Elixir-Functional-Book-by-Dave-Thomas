defmodule Chapter7.Exercise4Test do
  use ExUnit.Case
  @moduledoc """

  Write a function MyList.span(from, to) that returns a list of the numbers from from up to to.

  """

  defmodule List do
    def span(from, to) when from < to, do: _span(from, to)
    def span(_, _), do: []
    defp _span(to, to), do: [to]
    defp _span(from, to), do: [from | _span((from + 1), to)]
  end

  test "generate a list from a range" do
    assert List.span(0,5) == [0,1,2,3,4,5]
  end

  test "generate a empty list when the range is not valid" do
    assert List.span(5,0) == []
  end

end