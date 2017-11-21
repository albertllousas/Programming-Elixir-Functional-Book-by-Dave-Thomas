defmodule Chapter11.Exercise2Test do
  use ExUnit.Case
  @moduledoc """

  Write an anagram?(word1, word2) that returns true if its parameters are anagrams.

  """

  defmodule RecursiveSolution do
    def anagram?(word1, word2) when is_binary(word1) and is_binary(word2)  do
      anagram?(String.to_char_list(word1), String.to_char_list(word2))
    end
    def anagram?([], []), do: true
    def anagram?([], _), do: false
    def anagram?([head | tail], chars) do
      if Enum.member?(chars, head), do: anagram?(tail, List.delete(chars, head)), else: false
    end
  end

  defmodule SimpleSolution do
    def anagram?(sqs1, sqs2), do: Enum.sort(sqs1) == Enum.sort(sqs2)
  end


  #  def anagram(sqs1, sqs2), do: Enum.sort(sqs1) == Enum.sort(sqs2)  --> a simple solution

  test "should detect a correct anagram" do
    assert RecursiveSolution.anagram?('silent', 'listen') == true
  end

  test "should detect non anagram" do
    assert RecursiveSolution.anagram?('albert', 'ortiz') == false
  end

  test "should detect a correct anagram when inputs are string" do
    assert RecursiveSolution.anagram?("silent", "listen") == true
  end

  test "should detect a correct anagram with the simplest solution" do
    assert SimpleSolution.anagram?('silent', 'listen') == true
  end

  test "should detect non anagram with the simplest solution" do
    assert SimpleSolution.anagram?('albert', 'ortiz') == false
  end


end