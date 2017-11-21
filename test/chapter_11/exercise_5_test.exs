defmodule Chapter11.Exercise5Test do
  use ExUnit.Case
  @moduledoc """

    Write a function that takes a list of dqs and prints each on a separate line,
    centered in a column that has the width of the longest string. Make sure it works with UTF characters.

    iex> center(["cat", "zebra", "elephant"])
      cat
     zebra
    elephant

  """

  defmodule StringPrinter do
    def center(strings) do
      max_length(strings)
      |> center_strings_in_column(strings)
      |> Enum.each(&IO.puts(&1))
    end

    defp max_length(strings), do: Enum.map(strings, &String.length/1)
                                  |> Enum.max
    defp center_strings_in_column(column_size, strings) do
      Enum.map(
        strings,
        fn string ->
          padding = div((column_size - String.length(string)), 2)
          count = (padding + String.length(string))
          String.pad_leading(string, count)
        end
      )
    end
  end

  import ExUnit.CaptureIO

  test "prints and center in a column" do
    execute = fn -> StringPrinter.center(["cat", "zebra", "elephant"]) end
    assert capture_io(execute) == "  cat\n zebra\nelephant\n"
  end

end