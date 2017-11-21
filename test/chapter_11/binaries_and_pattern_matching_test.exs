defmodule Chapter11.BinariesAndPatternMatchingTest do
  use ExUnit.Case

  defmodule Utf8 do
    def map(str, func) when is_binary(str), do: _map(str, func)
    defp _map(<<head :: utf8, tail :: binary>>, func) do
      [func.(head) | _map(tail, func)]
    end
    defp _map(<<>>, _func), do: []
  end

  test "create map to apply on strings" do
    assert Utf8.map("∂og", fn char -> <<char :: utf8>> end) == ["∂", "o", "g"]
  end

end
