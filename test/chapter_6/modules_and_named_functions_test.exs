defmodule Chapter6.ModulesAndNamedFunctionsTest do
  use ExUnit.Case

  test "define a module named Times that contains a single function, double" do
    defmodule Times do
      def double(x) do
        x * 2
      end
    end
    assert Times.module_info() != nil
    assert TypeUtils.has_data_type(&Times.double/1, "Function")
  end

  test "the 'do...end' block is one way of grouping expressions but the underlying syntax is ', do:'" do
    defmodule Times, do: def double(x), do: x * 2
    assert Times.module_info() != nil
    assert TypeUtils.has_data_type(&Times.double/1, "Function")
  end

  test "specification of factorial using pattern matching on named functions" do
    defmodule Factorial do
      def of(0), do: 1
      def of(n), do: n * of(n - 1)
    end
    assert Factorial.of(0) == 1
    assert Factorial.of(1) == 1
    assert Factorial.of(2) == 2
    assert Factorial.of(3) == 6
    assert Factorial.of(7) == 5040
  end

  test "use 'guard clauses' to define an expression when pattern matching on named functions is not enough" do
    defmodule Guard do
      def what_is(x) when is_number(x), do: "#{x} is a number"
      def what_is(x) when is_list(x), do: "#{inspect(x)} is a list"
      def what_is(x) when is_atom(x), do: "#{x} is an atom"
    end

    assert Guard.what_is(99) == "99 is a number"
    assert Guard.what_is(:cat) == "cat is an atom"
    assert Guard.what_is([1, 2, 3]) == "[1, 2, 3] is a list"
  end

  test "factorial function can be rewriten using 'guard clauses' to evict infinite loops for negative values" do
    defmodule Factorial do
      def of(0), do: 1
      def of(n) when n > 0, do: n * of(n - 1)
    end
    assert_raise FunctionClauseError, fn -> Factorial.of(-1) end
  end

  test "'default parameters' are matched from left to right" do
    defmodule Example do
      def func(p1, p2 \\ 2, p3 \\ 3, p4), do: [p1, p2, p3, p4]
    end
    assert Example.func("a", "b") == ["a", 2, 3, "b"]
    assert Example.func("a", "b", "c") == ["a", "b", 3, "c"]
    assert Example.func("a", "b", "c", "d") == ["a", "b", "c", "d"]
    assert_raise UndefinedFunctionError, fn -> Example.func("a") end
  end

  test "definitions with multiple clauses and default values require
        a function head with no body that contains the default parameters" do

    defmodule Params do
      def func(p1, p2 \\ 123)
      def func(p1, p2) when is_list(p1), do: "You said #{p2} with a list"
      def func(p1, p2), do: "You passed in #{p1} and #{p2}"
    end

    assert Params.func(99) == "You passed in 99 and 123"
    assert Params.func(99, "cat") == "You passed in 99 and cat"
    assert Params.func([99]) == "You said 123 with a list"
    assert Params.func([99], "dog") == "You said dog with a list"
  end

  test "declare private functions with 'defp' keyword" do
    defmodule Sample do
      defp private_function(), do: "Hello!"
    end

    assert_raise UndefinedFunctionError, fn -> Sample.private_function() end
  end


  test "concatenate operation with pipe operator '|>'" do
    result_list = (1..10)
                  |> Enum.map(&(&1 * &1))
                  |> Enum.filter(&(&1 < 40))

    assert result_list === [1, 4, 9, 16, 25, 36]
  end

  test "the |> operator takes the result of the expression to its left
        and inserts it as the first parameter of the function invocation to its right." do

    f = &(&1 + &2 + &3)
    val = 1 + 1

    assert (val |> f.(2, 3)) === f.(val, 2, 3)
  end

  test "nested modules are allowed, so to access a function in a nested module from the outside scope,
        prefix it with all the module names" do
    defmodule Outer do
      defmodule Inner do
        def function(), do: "Hello!"
      end
    end
    assert Outer.Inner.function() == "Hello!"
  end

  test "the import directive brings a module’s functions and/or macros into the current scope
        in order to eliminate the need to repeat the module name time and again" do

    import List, only: [flatten: 1]
    assert flatten([5,[6,7],8]) == [5,6,7,8]
  end

  test "the alias directive creates an alias for a module." do

    defmodule Too.Long.Module do
        def function, do: "Hello!"
    end

    alias Too.Long.Module, as: M
    
    assert M.function == "Hello!"
  end

  test "modules can have attributes using the syntax '@name value'" do
    defmodule Example do
      @author "Dave Thomas"
      def get_author, do: @author
    end
    assert Example.get_author == "Dave Thomas"
  end

  test "the same attribute can be set multiple times in a module" do
    defmodule Example do
      @attr "one"
      def first, do: @attr
      @attr "two"
      def second, do: @attr
    end
    assert "#{Example.first} #{Example.second}" == "one two"
  end

  test "internally, module names are just atoms" do
    assert is_atom IO
    assert IO == :"Elixir.IO"
  end

  test "to call an Erlang function change the Erlang module name to an Elixir atom" do
    import ExUnit.CaptureIO
    assert capture_io(fn -> :io.format("The number is ~3.1f~n", [5.678]) end) == "The number is 5.7\n"
  end

end