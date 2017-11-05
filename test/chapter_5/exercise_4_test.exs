defmodule Chapter3.Exercise4Test do
  use ExUnit.Case
  @moduledoc """

  Write a function prefix that takes a string.
  It should return a new function that takes a second string.
  When that second function is called,
  it will return a string containing the first string, a space,
  and the second string.

  """

  def create_prefix_function, do:
    fn first -> (fn second -> "#{first} #{second}" end) end

  test "prefix funtion should concatenate two strings" do
    prefix = create_prefix_function()
    assert prefix.("John").("Doe") == "John Doe"
  end
end