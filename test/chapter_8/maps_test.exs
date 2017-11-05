defmodule Chapter8.MapsTest do
  use ExUnit.Case

  @map  %{name: "Dave", likes: "Programming", where: "Dallas"}

  test "access to keys of a map using 'Map.keys' function" do
    assert Map.keys(@map) == [:likes, :name, :where]
  end

  test "access to values of a map using 'Map.values' function" do
    assert Map.values(@map) == ["Programming", "Dave", "Dallas"]
  end

  test "access a map value using brackets key notation" do
    assert @map[:name] == "Dave"
  end

  test "access a map value using dot key notation" do
    assert @map.name == "Dave"
  end

  test "dropping from map using 'Map.drop' function" do
    assert Map.drop(@map, [:where, :likes]) == %{:name => "Dave"}
  end

  test "put key value to a mao using 'Map.put' function" do
    assert Map.put(@map, :also_likes, "Ruby") == %{
             name: "Dave",
             likes: "Programming",
             where: "Dallas",
             also_likes: "Ruby"
           }
  end

  test "ask for a key using 'Map.has_key?' function" do
    assert (Map.has_key? @map, :where) == true
  end

  test "pop value from a map using 'Map.pop' function" do
    {value, map} = Map.pop(@map, :name)
    assert value == "Dave" and map == %{likes: "Programming", where: "Dallas"}
  end

  test "map equality with 'Map.equals?' function" do
    map = %{name: "Dave", likes: "Programming", where: "Dallas"}
    assert Map.equal?(@map, map) == true
  end

end