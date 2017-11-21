defmodule Chapter11.Exercise7Test do
  use ExUnit.Case
  @moduledoc """

  Chapter 10 had an exercise about calculating sales tax.
  We now have the sales information in a file of comma-separated id, ship_to, and amount values.
  The file looks like this:

  id,ship_to,net_amount
  123,:NC,100.00
  124,:OK,35.50
  125,:TX,24.00
  126,:TX,44.80
  127,:NC,25.00
  128,:MA,10.00
  129,:CA,102.00
  120,:NC,50.00

  Write a function that reads and parses this file and then passes the result to the sales_tax function.
  Remember that the data should be formatted into a keyword list, and that the fields need to be the correct
  types (so the id field is an integer, and so on).

  You’ll need the library functions File.open, IO.read(file, :line), and IO.stream(file).

  """
  defmodule CSVTaxes do

    def parse(file_path) do
      file = File.open!(file_path)
      list_of_headers = csv_header_to_list(file)
      file
      |> IO.stream(:line)
      |> Stream.map(&process_line(&1, list_of_headers))
      |> Enum.to_list
    end

    defp csv_header_to_list(file), do: IO.read(file, :line)
                                       |> String.trim
                                       |> String.split(",")
                                       |> Enum.map(&String.to_atom(&1))

    defp process_line(line, list_of_headers) do
      values = line
               |> String.trim
               |> String.split(",")

      Enum.zip(list_of_headers, values) |> parse_types
    end

    defp parse_types([id: id, ship_to: ship_to, net_amount: net_amount]) do
      [
        id: String.to_integer(id),
        ship_to: String.replace(ship_to, ":", "") |> String.to_atom,
        net_amount: String.to_float(net_amount)
      ]
    end

  end


  test "should parse csv orders as expected for Taxes module" do

    alias Chapter10.Exercise8ListAndRecursion.Taxes, as: Taxes

    orders = CSVTaxes.parse("test/chapter_11/orders")
    tax_rates = [NC: 0.075, TX: 0.08]
    result = Taxes.apply(orders, tax_rates)
    assert result == [
             [id: 123, ship_to: :NC, net_amount: 100.0, total_amount: 107.5],
             [id: 124, ship_to: :OK, net_amount: 35.5, total_amount: 35.5],
             [id: 125, ship_to: :TX, net_amount: 24.0, total_amount: 25.92],
             [id: 126, ship_to: :TX, net_amount: 44.8, total_amount: 48.384],
             [id: 127, ship_to: :NC, net_amount: 25.0, total_amount: 26.875],
             [id: 128, ship_to: :MA, net_amount: 10.0, total_amount: 10.0],
             [id: 129, ship_to: :CA, net_amount: 102.0, total_amount: 102.0],
             [id: 120, ship_to: :NC, net_amount: 50.0, total_amount: 53.75]
           ]

  end

end