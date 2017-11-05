defmodule Chapter8.KeywordListTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  defmodule Canvas do

    @defaults [fg: "black", bg: "white", font: "Merriweather"]

    def draw_text(text, options \\ []) do
      options = Keyword.merge(@defaults, options)
      IO.puts "Drawing text   #{inspect(text)}"
      IO.puts "Foreground:    #{options[:fg]}"
      IO.puts "Background:    #{Keyword.get(options, :bg)}"
      IO.puts "Font:          #{Keyword.get(options, :font)}"
      IO.puts "Pattern:       #{Keyword.get(options, :pattern, "solid")}"
      IO.puts "Style:         #{inspect Keyword.get_values(options, :style)}"
    end
  end

  test "keyword lists are typically used in the context of options passed to functions." do
    execute = fn -> Canvas.draw_text("hello", fg: "red", style: "italic", style: "bold") end
    expected_result = "Drawing text   \"hello\"\nForeground:    red\nBackground:    white\nFont:          Merriweather\nPattern:       solid\nStyle:         [\"italic\", \"bold\"]\n"
    assert capture_io(execute) == expected_result

  end

end