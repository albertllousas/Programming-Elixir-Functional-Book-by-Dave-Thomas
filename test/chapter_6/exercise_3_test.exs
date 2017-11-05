defmodule Chapter6.Exercise3Test do
  use ExUnit.Case
  @moduledoc """

  Add a quadruple function. (Maybe it could call the double function....)

  defmodule Times do
    def double(n), do: n * 2
  end

  """

  defmodule Times do
    def double(x), do: x * 2
    def quadruple(x), do: double(x) * 2
  end

  test "function quadruple added multiplies its parameter by four" do
    assert Times.quadruple(2) == 8
  end

end