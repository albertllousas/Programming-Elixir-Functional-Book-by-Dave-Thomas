defmodule Chapter5.Exercise5Test do
  use ExUnit.Case
  @moduledoc """
    
  Use the &... notation to rewrite the following.  
    
  """

  test "Enum.map [1,2,3,4], fn x -> x + 2 end" do
    numbers = [1,2,3,4]
    add_2 = fn x -> x + 2 end
    add_2_shorcut = &(&1 + 2)
    assert Enum.map(numbers, add_2) == Enum.map(numbers, add_2_shorcut)
  end

end