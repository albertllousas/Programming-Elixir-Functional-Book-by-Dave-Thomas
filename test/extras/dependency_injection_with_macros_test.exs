defmodule Extras.DependencyInbjectionWithMacrosTest do
  use ExUnit.Case


  defmodule TestMacro do

    defmacro __using__(opts) do
      quote bind_quoted: [opts: opts] do
        @name Keyword.fetch!(opts, :name)

        def name(), do: @name
      end
    end
  end

  defmodule TesMacroImpl do
    use TestMacro, name: "xxxxxxxxxxx"
  end

  test "dddd" do
    IO.puts(TesMacroImpl.name)
  end

  defmodule Hello do
    defmacro __using__(opts) do
      greeting = Keyword.get(opts, :greeting, "Hi")

      quote do
        def hello(name), do: unquote(greeting) <> ", " <> name
      end
    end
  end

  defmodule Example do
    use Hello, greeting: "Hola"
  end

  test "cccccccc" do
    IO.puts(Example.hello("Sean"))
  end

end