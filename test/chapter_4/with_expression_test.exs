defmodule Chapter4.WithExpressionTest do
  use ExUnit.Case

  test "'with' allows you to define a local scope for variables" do
    values = [1,2,3]
    count = 10000
    mean = with count = Enum.count(values),
                sum = Enum.sum(values)
      do
      sum / count
    end
    assert mean === 2.0
    assert count == 10000
  end

end