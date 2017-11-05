defmodule Chapter4.MapTypeTest do
  use ExUnit.Case

  test "maps literals are written using '%{ key => value, key => value }'" do
    assert is_map %{:a => 1, :b => 2}
  end

  test "elixir give a shorcut to write maps of two-value tuples if the keys are atoms" do
    assert %{ a: 1, b: 2} ==  %{:a => 1, :b => 2}
  end

  test "keys on maps can be of different type" do
    assert is_map %{ "one" => 1, :two => 2, {1,1,1} => 3 }
  end

  test "keys on maps can be expressions" do
    name = "John Doe"
    assert %{ String.downcase(name) => name } == %{"john doe" => "John Doe"}
  end

  test "extract values from a map is done using the square-bracket syntax" do
    states = %{ "AL" => "Alabama", "WI" => "Wisconsin" }
    assert states["AL"] == "Alabama"
  end

  test "if the keys are atoms, dot notation can be used to extract values" do
    colors = %{ red: 0xff0000, green: 0x00ff00, blue: 0x0000ff }
    assert colors.red == 0xff0000
  end

end