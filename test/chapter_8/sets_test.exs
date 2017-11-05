defmodule Chapter8.SetsTest do
  use ExUnit.Case


  test "Sets are implemented using the module MapSet." do
    set1 = 1..5
           |> Enum.into(MapSet.new)
    set2 = 3..8
           |> Enum.into(MapSet.new)
    assert MapSet.member?(set1, 3) == true
    assert MapSet.union(set1, set2) == MapSet.new [1, 2, 3, 4, 5, 6, 7, 8]
    assert MapSet.difference(set1, set2) == MapSet.new [1, 2]
    assert MapSet.difference(set2, set1) == MapSet.new [6, 7, 8]
    assert MapSet.intersection(set2, set1) == MapSet.new [3, 4, 5]
  end



end