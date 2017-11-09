defmodule Chapter11.StringLiteralsTest do
  use ExUnit.Case

  test "allow interpolation on string expressions " do
    name = "Dave"
    assert "Hello, #{String.capitalize name}!" == "Hello, Dave!"
  end

  test "heredoc notation allow add multiline strings" do
    multi_line = """
    multi
    line
    string
    """
    assert multi_line == "multi\nline\nstring\n"
  end

end