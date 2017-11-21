defmodule Chapter11.SinlgeQuotedStringTest do
  use ExUnit.Case

  test "Single-quoted strings (or char lists) are represented as a list of integer values,
        each value corresponding to a codepoint in the string. " do

    str = 'wombat'
    str2 = "wombat"

    assert is_list str
    assert !is_list str2
  end

  test "iex prints a list of integers as a string if it believes each number in the list is a printable character" do
    assert [67, 65, 84] == 'CAT'
  end

  test "Because a character list is a list, we can use the usual pattern matching and List functions." do
    assert 'pole' ++ 'vault' == 'polevault'
    assert 'pole' -- 'vault' == 'poe'
    assert List.zip(['abc', '123']) == [{97, 49}, {98, 50}, {99, 51}]
    [head | tail] = 'cat'
    assert head == 99
    assert tail == 'at'
  end

  test "module that parses the character-list representation of an optionally signed decimal number" do
    # the notation ?c returns the integer code for the character c.
    # This is often useful when employing patterns to extract information from character lists

    defmodule Parse do
      def number([?- | tail]), do: _number_digits(tail, 0) * -1
      def number([?+ | tail]), do: _number_digits(tail, 0)
      def number(str), do: _number_digits(str, 0)

      defp _number_digits([], value), do: value
      defp _number_digits([digit | tail], value) when digit in '0123456789' do
        _number_digits(tail, value * 10 + _to_number digit )
      end
      defp _number_digits([non_digit | _], _), do: raise "Invalid digit '#{[non_digit]}'"
      defp _to_number(digit), do: digit - ?0
    end

    assert Parse.number('123') == 123
    assert Parse.number('-123') == -123
    assert Parse.number('+123') == 123
    assert_raise RuntimeError, fn -> Parse.number('+a') end

  end

end