defmodule Chapter11.Exercise3Test do
  use ExUnit.Case
  @moduledoc """

  Try the following in iex:

    iex> [ 'cat' | 'dog' ] ['cat',100,111,103]

  Why does iex print 'cat' as a string, but 'dog' as individual numbers?

  """

  test "appending a list of codepoints with a list of codepoints with cons '|' operator, cause
       a list af codepints as a head of the new list" do
    assert ['cat' | 'dog'] == ['cat', 100, 111, 103]
  end

  test "appending a list of codepoints with a list of codepoints with cons '++' operator, cause
       a list af codepoints" do
    assert 'cat' ++ 'dog' == [99, 97, 116, 100, 111, 103]
  end

end