defmodule Chapter11.Exercise6Test do
  use ExUnit.Case
  @moduledoc """

    Write a function to capitalize the sentences in a string. Each sentence is terminated by a period and a space.
    Right now, the case of the characters in the string is random.

    iex> capitalize_sentences("oh. a DOG. woof. ") "Oh. A dog. Woof. "

  """

  defmodule Text do
    @sentence_delimiter ". "
    def capitalize_sentences(text) do
      String.split(text, @sentence_delimiter)
      |> Enum.map(&String.capitalize(&1))
      |> Enum.join(@sentence_delimiter)
    end
  end

  test "capitalize phrases in text" do
    assert Text.capitalize_sentences("oh. a DOG. woof. ") == "Oh. A dog. Woof. "
  end

end