defmodule Chapter10.StreamsTest do
  use ExUnit.Case

  test "creating a simple stream" do
    stream = Stream.map [1, 3, 5, 7], &(&1 + 1)
    assert TypeUtils.has_data_type(stream, "Stream")
  end

  test "stream to start giving us results treating it as a collection and pass it to a function in the Enum module" do
    stream = Stream.map [1, 3, 5, 7], &(&1 + 1)
    assert Enum.to_list(stream) == [2, 4, 6, 8]
  end

  test "Compose stream to filter the odds numbers of a list previously square and plus one" do
    result = [1, 2, 3, 4]
             |> Stream.map(&(&1 * &1))
             |> Stream.map(&(&1 + 1))
             |> Stream.filter(fn x -> rem(x, 2) == 1 end)
             |> Enum.to_list
    assert result == [5, 17]
  end

  test "find longest-line written in a file using streams" do
    longest_line = File.stream!("test/chapter_10/words")
                   |> Enum.max_by(&String.length/1)
    assert longest_line == "ill-fated\n"
  end

  test "create a 10-million element stream, then evaluate the first five elements from it" do
    first_five = Stream.map(1..10_000_000, &(&1 + 1))
                 |> Enum.take(5)
    assert first_five == [2, 3, 4, 5, 6]
  end

  test "generate rows in an HTML table with alternating green and white classes using 'Stream.cycle'" do
    html = Stream.cycle(~w{ green white }) #~w sigil is used to generate lists of words
           |> Stream.zip(1..4)
           |> Enum.map(fn {class, value} -> ~s{<tr class="#{class}"><td>#{value}</td></tr>\n} end)
    assert html == [
             "<tr class=\"green\"><td>1</td></tr>\n",
             "<tr class=\"white\"><td>2</td></tr>\n",
             "<tr class=\"green\"><td>3</td></tr>\n",
             "<tr class=\"white\"><td>4</td></tr>\n"
           ]
  end

  test "use 'Stream.repeatedly' to take a function and invokes it each time a new value is wanted" do
    assert (
             Stream.repeatedly(fn -> true end)
             |> Enum.take(3)
             ) == [true, true, true]
  end

  test "use 'Stream.iterate(start_value, next_fun)' to generate an infinite stream" do
    count_to_five = Stream.iterate(0, &(&1 + 1))
                    |> Enum.take(5)
    assert count_to_five = [1, 2, 3, 4, 5]
  end

  test "use 'Stream.unfold' to generate a stream of Fibonacci numbers" do
    first_15_fibo = Stream.unfold({0, 1}, fn {f1, f2} -> {f1, {f2, f1 + f2}} end)
                    |> Enum.take(15)
    assert first_15_fibo == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]

  end

end