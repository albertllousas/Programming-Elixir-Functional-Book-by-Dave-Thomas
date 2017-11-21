defmodule Chapter11.Exercise4Test do
  use ExUnit.Case
  @moduledoc """

    (Hard) Write a function that takes a single-quoted string of the form number [+-*/]
    and returns the result of the calculation.
    The individual numbers do not have leading plus or minus signs.

    calculate('123 + 27') # => 150

  """

  defmodule Calculator do
    def calculate(operation) do
      {operand1, operator, operand2} = extract_parts(operation)
      calculate(operator, operand1, operand2)
    end

    defp calculate('+', operand1, operand2), do: operand1 + operand2
    defp calculate('-', operand1, operand2), do: operand1 - operand2
    defp calculate('*', operand1, operand2), do: operand1 * operand2
    defp calculate('/', operand1, operand2), do: div(operand1, operand2)

    defp extract_parts(operation) do
      is_space? = &(&1 == (? ))
      is_operator? = &(&1 in '+-/*')
      [operand1, operator, operand2] = operation
                                       |> Enum.reject(is_space?)
                                       |> Enum.chunk_by(is_operator?)
      {chars_to_integer(operand1), operator, chars_to_integer(operand2)}
    end

    defp chars_to_integer(characters) do
      characters
      |> to_string
      |> String.to_integer
    end
  end

  test "Calculator is adding" do
    assert Calculator.calculate('10 + 2') == 12
  end

  test "Calculator is substracting" do
    assert Calculator.calculate('10 - 2') == 8
  end

  test "Calculator is multiplying" do
    assert Calculator.calculate('10 * 2') == 20
  end

  test "Calculator is dividing" do
    assert Calculator.calculate('10 / 2') == 5
  end

end