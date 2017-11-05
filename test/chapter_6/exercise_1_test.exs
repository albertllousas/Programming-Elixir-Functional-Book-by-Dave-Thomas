defmodule Chapter6.Exercise1Test do
  use ExUnit.Case
  @moduledoc """

  Extend the Times module with a triple function that multiplies its parameter by three.

  defmodule Times do
    def double(n), do: n * 2
  end

  """

  defmodule Times do
    def double(x), do: x * 2
    def triple(x), do: x * 3
  end

  test "function triple added multiplies its parameter by three" do
    assert Times.triple(3) == 9
  end

end