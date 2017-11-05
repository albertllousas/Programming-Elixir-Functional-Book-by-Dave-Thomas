defmodule Chapter4.DateAndTimeTest do
  use ExUnit.Case

  test "Date type holds a year, month, day in ISO-8601" do
    date = Date.new(2016, 12, 25)
    assert date == {:ok, ~D[2016-12-25]}
    assert TypeUtils.has_data_type elem(date,1), "Date"
  end

  test "Time type contains an hour, minute, second, and fractions of a second" do
    time = Time.new(12, 34, 56)
    assert time == {:ok, ~T[12:34:56]}
    assert TypeUtils.has_data_type elem(time,1), "Time"
  end
end