defmodule Chapter11.DoubleQuotedStringsTest do
  use ExUnit.Case

  test "returns the grapheme at the given offset (starting at 0). Negative offsets count from the end of the string" do
    assert String.at("∂og", 0) == "∂"
    assert String.at("∂og", -1) == "g"
  end

  test "converts str to lowercase, and then capitalizes the first character" do
    assert String.capitalize("école") == "École"
    assert String.capitalize("ÎÎÎÎÎ") == "Îîîîî"
  end

  test "returns the codepoints in str" do
    assert String.codepoints("José's ∂øg") == ["J", "o", "s", "e", "́", "'", "s", " ", "∂", "ø", "g"]
  end

  test "converts str to lowercase" do
    assert String.downcase("ØRSteD") == "ørsted"
  end

  test "returns a string containing n copies of str" do
    assert String.duplicate("Ho! ", 3) == "Ho! Ho! Ho! "
  end

  test "true if str ends with any of the given suffixes" do
    assert String.ends_with?("string", ["elix", "stri", "ring"]) == true
  end

  test "returns the first grapheme from str" do
    assert String.first("∂og") == "∂"
  end

  test "returns a float between 0 and 1 indicating the likely similarity of two strings" do
    assert String.jaro_distance("jonathan", "jonathon") == 0.9166666666666666
    assert String.jaro_distance("josé", "john") == 0.6666666666666666
  end

  test "returns the last grapheme from str" do
    assert String.last("∂og") == "g"
  end

  test "returns the number of graphemes in str" do
    assert String.length("∂x/∂y") == 5
  end

  test "returns the list of transformations needed to convert one string to another" do
    assert String.myers_difference("banana", "panama") == [del: "b", ins: "p", eq: "ana", del: "n", ins: "m", eq: "a"]
  end

  test "splits str into its leading codepoint and the rest, or nil if str is empty" do

    defmodule MyString do
      def map(str, func), do: _map(String.next_codepoint(str), func)
      defp _map({codepoint, rest}, func) do
        [func.(codepoint) | _map(String.next_codepoint(rest), func)]
      end
      defp _map(nil, _), do: []
    end

    assert MyString.map("∂og", fn c -> c end) == ["∂", "o", "g"]
  end

  test "returns a new string, at least new_length characters long, containing str right-justified and padded with padding" do
    assert String.pad_leading("cat", 6, ">") == ">>>cat"
  end

  test "returns a new string, at least new_length characters long, containing str left-justified and padded with padding" do
    assert String.pad_trailing("cat", 6, "<") == "cat<<<"
  end

  test "returns true if str contains only printable characters" do
    assert String.printable?("José") == true
    assert String.printable?("\x{0000} a null") == false
  end

  test "replaces pattern with replacement in str under control of options" do
    assert String.replace("the cat on the mat", "at", "AT") == "the cAT on the mAT"
    assert String.replace("the cat on the mat", "at", "AT", global: false) == "the cAT on the mat"
    assert String.replace("the cat on the mat", "at", "AT", insert_replaced: 0) == "the catAT on the matAT"
    assert String.replace("the cat on the mat", "at", "AT", insert_replaced: [0,2]) == "the catATat on the matATat"
  end

  test "reverses the graphemes in a string" do
    assert String.reverse("pupils") == "slipup"
    assert String.reverse("∑ƒ÷∂") == "∂÷ƒ∑"
  end

  test "returns a len character substring starting at offset" do
    assert String.slice("the cat on the mat", 4, 3) == "cat"
    assert String.slice("the cat on the mat", -3, 3) == "mat"
  end

  test "splits str into substrings delimited by pattern" do
    assert String.split(" the cat on the mat ") ==  ["the", "cat", "on", "the", "mat"]
  end

  test "true if str starts with any of the given prefixes" do
    assert String.starts_with?("string", ["elix", "stri", "ring"]) == true
  end

  test "trims leading and trailing whitespace from str" do
    assert String.trim("\t Hello \r\n") == "Hello"
  end

  test "trims leading and trailing instances of character from str" do
    assert String.trim("!!!SALE!!!", "!") == "SALE"
  end

  test "upcase str" do
    assert String.upcase("José Ørstüd") == "JOSÉ ØRSTÜD"
  end

  test "returns true if str is a single-character string containing a valid codepoint" do
    assert String.valid?("∂") == true
  end

end