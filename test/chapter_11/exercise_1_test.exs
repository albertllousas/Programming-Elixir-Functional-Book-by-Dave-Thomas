defmodule Chapter11.Exercise1Test do
  use ExUnit.Case
  @moduledoc """

  Write a function that returns true if a single-quoted string contains only printable ASCII characters (space through tilde).

  """

  defmodule SingleQuoted do
    def is_printable?([]), do: true
    def is_printable?([head | tail]) do
      if (is_ascii?(head)), do: is_printable?(tail), else: false
    end
    defp is_ascii?(c) do
      c >= 0 and c <= 175 and String.printable?(to_string [c])
    end
  end

  test "check single quoted string with ASCII characters returns true" do
#    for i <- 0 .. 175,do: IO.puts List.to_string([i])
    assert SingleQuoted.is_printable?('!albert ortiz') == true
  end

  test "check single quoted string with non ASCII characters returns false" do
    assert SingleQuoted.is_printable?('Λιßεπτ ortiz') == false
  end

end