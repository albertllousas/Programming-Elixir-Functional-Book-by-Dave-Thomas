defmodule Chapter4.AnonymousFunctionsTest do
  use ExUnit.Case

  test "define an anonymous function and bind it to the variable sum" do
    sum = fn a, b -> a + b end
    assert TypeUtils.has_data_type(sum, "Function")
  end

  test "dot indicates the function call, and the arguments are passed between parentheses" do
    sum = fn a, b -> a + b end
    assert sum.(1, 2) == 3
  end

  test "anonymous function that swap elements of a simpe tuple" do
    swap = fn {a, b} -> {b, a} end
    assert swap.({1, 2}) == {2, 1}
  end

  test "one function can have multiples bodies and use pattern matching to select which clause to run" do
    handle_open = fn
      {:ok, file} -> "First line: #{IO.read(file, :line)}"
      {_, error} -> "Error: #{:file.format_error(error)}"
    end
    assert handle_open.(File.open("test/chapter_5/hello.exs")) == "First line: IO.puts \"Hello, World!\""
    assert handle_open.(File.open("nonexistent")) == "Error: no such file or directory"
  end

  test "functions can return functions" do
    fun = fn -> (fn -> "Hello" end) end
    assert fun.().() == "Hello"
  end

  test "functions automatically carry with bindings of variables in the scope in which they are defined (closure)" do
    greeter = fn name -> (fn -> "Hello #{name}" end) end
    dave_greeter = greeter.("Dave")
    assert dave_greeter.() == "Hello Dave"
  end

  test "an inner function that adds the value of its parameter to the value of the outer function’s parameter" do
    add_n = fn n -> (fn other -> n + other end) end
    add_two = add_n.(2)
    add_three = add_n.(3)
    assert add_two.(2) == 4
    assert add_three.(2) == 5
  end

  test "functions are just values, so we can pass them to other functions as arguments" do
    times_2 = fn n -> n * 2 end
    apply = fn (fun, value) -> fun.(value) end
    assert apply.(times_2, 6) == 12
  end

  test "passing function as argument inline to another function" do
    assert Enum.map([1, 2, 3], fn elem -> elem * 2 end) == [2, 4, 6]
  end

  test "use pin operator (^) to use the current value of a outer scoped variable in a inner function pattern" do
    greeter_for = fn (name, greeting) ->
      fn
        (^name) -> "#{greeting} #{name}"
        (_) -> "I don't know you"
      end
    end
    mr_valim = greeter_for.("José", "Oi!")
    assert mr_valim.("José") == "Oi! José"
    assert mr_valim.("dave") == "I don't know you"
  end

  test "elixir provides an strategy (shorcut) of creating short helper functions (& notation)" do
    shorcut = &(&1 + 1)
    fun = fn (x) -> x + 1 end
    random_number = Enum.random(0..1000)
    assert shorcut.(random_number) == fun.(random_number)
  end

  test "literal lists and tuples can also be turned into functions" do
    div_rem = &{div(&1, &2), rem(&1, &2)}
    assert div_rem.(13, 5) == {2, 3}
  end

  test "give it the name and arity of an existing named function, return an anonymous function that calls it" do
    l = &length/1
    assert l.([1,3,5,7]) == 4
  end

end