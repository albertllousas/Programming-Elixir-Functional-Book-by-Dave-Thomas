defmodule Chapter8.PatternMatchingAndUpdatingMapsTest do
  use ExUnit.Case

  @person %{name: "Dave", height: 1.88}

  @people  [
    %{name: "Grumpy", height: 1.24},
    %{name: "Dave", height: 1.88},
    %{name: "Dopey", height: 1.32},
    %{name: "Shaquille", height: 2.16},
    %{name: "Sneezy", height: 1.28}
  ]

  test "use pattern matching to check if there is an entry with the key :name" do
    %{name: a_name} = @person
    assert a_name == "Dave"
  end

  test "use pattern matching to check if there are entries for the keys :name and :height" do
    assert %{name: _, height: _} = @person
  end

  test "use pattern matching to check uf there is an entry with key :name have the value 'Dave'" do
    assert %{name: "Dave"} = @person
  end

  test "pattern matching fails when a key doesn't exists" do
    assert_raise MatchError, fn -> %{name: _, weight: _} = @person end
  end

  test "using pattern matching to filter a list of person in a comprehension" do

    filtered_list = for person = %{height: height} <- @people, height > 1.5, do: person

    assert filtered_list == [%{height: 1.88, name: "Dave"}, %{height: 2.16, name: "Shaquille"}]
  end

  test "pattern matching with maps also works in any other circumstance in which patterns are used" do
    defmodule HotelRoom do
      def book(%{name: name, height: height}) when height > 1.9, do: "Need extra long bed for #{name}"
      def book(%{name: name, height: height}) when height < 1.3, do: "Need low shower controls for #{name}"
      def book(person), do: "Need regular bed for #{person.name}"
    end

    expected = [
      "Need low shower controls for Grumpy",
      "Need regular bed for Dave",
      "Need regular bed for Dopey",
      "Need extra long bed for Shaquille",
      "Need low shower controls for Sneezy"
    ]

    assert (@people
            |> Enum.map(&HotelRoom.book/1)
             ) == expected
  end

  test "pattern matching can match variable keys using the pin operator" do
    data = %{name: "Dave", state: "TX", likes: "Elixir"}
    result = for key <- [:name, :likes] do
      %{^key => value} = data
      value
    end

    assert result = ["Dave", "Elixir"]
  end

  test "the simplest way to update a map is with this syntax: new_map = %{ old_map | key => value, ... }" do
    m = %{ a: 1, b: 2, c: 3 }
    m1 = %{ m | b: "two", c: "three" }
    m2 = %{ m1 | a: "one" }
    assert m1 == %{ a: 1, b: "two", c: "three" }
    assert m2 == %{ a: "one", b: "two", c: "three" }
  end

end