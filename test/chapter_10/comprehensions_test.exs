defmodule Chapter10.ComprehensionsTest do
  use ExUnit.Case

  test "use the general-purpose shortcut comprehensions to map and filter a collection of integers " do
    squares = for x <- [1, 2, 3, 4, 5], do: x * x
    squares_filtered = for x <- [1, 2, 3, 4, 5], x < 4, do: x * x
    assert squares == [1, 4, 9, 16, 25]
    assert squares_filtered == [1, 4, 9]
  end

  test "if we have two generators, their operations are nested" do
    tuples = for x <- [1, 2], y <- [5, 6], do: {x, y}
    assert tuples == [{1, 5}, {1, 6}, {2, 5}, {2, 6}]
  end

  test "use variables from generators in later generators" do
    min_maxes = [{1, 4}, {2, 3}, {10, 15}]
    result = for {min, max} <- min_maxes, n <- min..max, do: n
    assert result == [1, 2, 3, 4, 2, 3, 10, 11, 12, 13, 14, 15]
  end

  test "use a comprehension to list pairs of numbers from 1 to 8 whose product is a multiple of 10" do
    first8 = [1, 2, 3, 4, 5, 6, 7, 8]
    result = for x <- first8, y <- first8, x >= y, rem(x * y, 10) == 0, do: {x, y}
    assert result == [{5, 2}, {5, 4}, {6, 5}, {8, 5}]
  end

  test "a comprehension that swaps the keys and values in a keyword list (deconstructing structured data)" do
    reports = [ dallas: :hot, minneapolis: :cold, dc: :muggy, la: :smoggy ]
    swapped = for { city, weather } <- reports, do: { weather, city }
    assert swapped == [hot: :dallas, cold: :minneapolis, muggy: :dc, smoggy: :la]
  end

  test "all variable assignments inside a comprehension are local to that comprehension,
       you will not affect the value of a variable in the outer scope" do
    name = "Dave"
    for name <- [ "cat", "dog" ], do: String.upcase(name)
    assert name == "Dave"
  end

  test "populate a map using a comprehension and 'into:'" do
    map = for x <- ~w{ cat dog }, into: Map.new, do: { x, String.upcase(x) }
    map2 = for x <- ~w{ cat dog }, into: %{"ant" => "ANT"}, do: { x, String.upcase(x) }
    assert map == %{"cat" => "CAT", "dog" => "DOG"}
    assert map2 == %{"ant" => "ANT", "cat" => "CAT", "dog" => "DOG"}
  end

end