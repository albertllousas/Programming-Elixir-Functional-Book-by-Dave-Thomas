defmodule Chapter4.ValueTypesTest do
  use ExUnit.Case

  test "integer can be written as decimals" do
    assert is_integer 1000
  end

  test "integer can be written with underscores" do
    assert is_integer 1_000_000
  end

  test "floating-point numbers are written using a decimal point" do
    assert is_float 1.0
  end

  test "atoms writen them using a leading colon (:) followed by an atom word" do
    assert is_atom :atom
  end

  test "ranges are represented as start..end, where start and end are integers" do
    assert TypeUtils.has_data_type 0..10, "Range"
  end

end