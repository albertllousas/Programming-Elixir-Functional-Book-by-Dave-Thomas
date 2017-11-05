ExUnit.start()

Code.compiler_options(ignore_module_conflict: true)

defmodule TypeUtils do
  def has_data_type(value, type) do
    #    IO.inspect(IEx.Info.info(value))
    IEx.Info.info(value)[:"Data type"] == type
  end
end