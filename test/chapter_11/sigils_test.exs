defmodule Chapter11.SigilsTest do
  use ExUnit.Case

  test "~C A character list with no escaping or interpolation" do
    assert ~C[1\n2#{1+2}] == '1\\n2\#{1+2}'
  end

  test "~c A character list, escaped and interpolated just like a single-quoted string" do
    assert ~c"1\n2#{1 + 2}" == '1\n23'
  end

  test "~D A Date in the format yyyy-mm-dd" do
    assert ~D<1999-12-31> == elem(Date.new(1999, 12, 31), 1)
  end

  test "~S A string with no escaping or interpolation" do
    assert ~S[1\n2#{1+2}] == "1\\n2\#{1+2}"
  end

  test "~s A string, escaped and interpolated just like a double-quoted string" do
    assert ~s/1\n2#{1 + 2}/ == "1\n23"
  end

  test "~T A Time in the format hh:mm:ss[.dddd]" do
    assert ~T[12:34:56] == elem(Time.new(12, 34, 56), 1)
  end

  test "~W A list of whitespace-delimited words, with no escaping or interpolation" do
    assert ~W[the c#{'a'}t sat on the mat] == ["the", "c\#{'a'}t", "sat", "on", "the", "mat"]
  end

  test "~w A list of whitespace-delimited words, with escaping and interpolation" do
    assert ~w[the c#{'a'}t sat on the mat] == ["the", "cat", "sat", "on", "the", "mat"]
  end

  test "The ~W and ~w sigils take an optional type specifier, a, c, or s,
        which determines whether it returns atoms, a list, or strings of characters" do
    assert ~w[the c#{'a'}t sat on the mat]a == [:the, :cat, :sat, :on, :the, :mat]
    assert ~w<the c#{'a'}t sat on the mat>c == ['the', 'cat', 'sat', 'on', 'the', 'mat']
    assert ~w[the c#{'a'}t sat on the mat]s == ["the", "cat", "sat", "on", "the", "mat"]
  end

  test "opening delimiter is three single or three double quotes, the sigil is treated as a heredoc" do
    assert ~w"""
           the
           cat
           sat
           """ == ["the", "cat", "sat"]
  end

end