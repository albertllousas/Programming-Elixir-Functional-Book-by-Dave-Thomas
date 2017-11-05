defmodule Chapter8.DynamicNestedAccessorsTest do
  use ExUnit.Case

  test "to access a nested struct in a dynamic way we can use functions instead macros" do
    nested = %{
      buttercup: %{
        actor: %{
          first: "Robin",
          last: "Wright"
        },
        role: "princess"
      },
      westley: %{
        actor: %{
          first: "Cary",
          last: "Ewles"
        },
        role: "farm boy"
      }
    }
    assert get_in(nested, [:buttercup, :actor, :first]) == "Robin"
  end

  test "There’s a cool trick that the dynamic versions of both 'get_in' and 'get_and_update_in' support
        if you pass a function as a key, that function is invoked to return the corresponding values" do
    authors = [
      %{name: "José", language: "Elixir"},
      %{name: "Matz", language: "Ruby"},
      %{name: "Larry", language: "Perl"}
    ]
    languages_with_an_r = fn (:get, collection, next_fn) ->
      for row <- collection do
        if String.contains?(row.language, "r") do
          next_fn.(row)
        end
      end
    end
    assert get_in(authors, [languages_with_an_r, :name]) == ["José", nil, "Larry"]

  end

  test "use Access Module with Nested accessors to traverse lists" do
    cast = [
      %{
        character: "Buttercup",
        actor: %{
          first: "Robin",
          last: "Wright"
        },
        role: "princess"
      },

      %{
        character: "Westley",
        actor: %{
          first: "Cary",
          last: "Elwes"
        },
        role: "farm boy"
      }
    ]


    all_characters = get_in(cast, [Access.all(), :character])
    second_role = get_in(cast, [Access.at(1), :role])
    tuple = get_and_update_in(cast, [Access.all(), :actor, :last], fn (val) -> {val, String.upcase(val)} end)

    assert all_characters == ["Buttercup", "Westley"]
    assert second_role == "farm boy"
    assert elem(tuple, 0) == ["Wright", "Elwes"]
  end


  test "use function 'elem' on Access Module to access tuple elements when traverse a list" do
    cast = [
      %{
        character: "Buttercup",
        actor: {"Robin", "Wright"},
        role: "princess"
      },

      %{
        character: "Westley",
        actor: {"Cary", "Elwes"},
        role: "farm boy"
      }
    ]
    second_actors = get_in(cast, [Access.all(), :actor, Access.elem(1)])
    assert second_actors == ["Wright", "Elwes"]
  end

  test "use 'key' function to work on dictionary types" do
    cast = %{
      buttercup: %{
        actor: {"Robin", "Wright"},
        role: "princess"
      },
      westley: %{
        actor: {"Carey", "Elwes"},
        role: "farm boy"
      }
    }

    westley_second_actor = get_in(cast, [Access.key(:westley), :actor, Access.elem(1)])
    assert westley_second_actor == "Elwes"
  end

  test "Access.pop lets you remove the entry with a given key from a map or keyword list" do
    assert Access.pop(%{name: "Elixir", creator: "Valim"}, :name) == {"Elixir", %{:creator => "Valim"}}
    assert Access.pop([name: "Elixir", creator: "Valim"], :name) == {"Elixir", [creator: "Valim"]}
    assert Access.pop(%{name: "Elixir", creator: "Valim"}, :year) == {nil, %{creator: "Valim", name: "Elixir"}}
  end


end