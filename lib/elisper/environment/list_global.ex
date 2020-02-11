defmodule Elisper.Environment.ListGlobal do
  @moduledoc """
  Defines the global environement for list-based environments.
  """
  import Elisper.Environment.ListEnv

  def init() do
    # TODO change signature to support piping.
      env = define_variable(:+, fn(operands, eval, env) -> add(operands, eval, env) end, empty())
      env = define_variable(:-, fn(operands, eval, env) -> subtract(operands, eval, env) end, env)
      env = define_variable(:*, fn(operands, eval, env) -> multiply(operands, eval, env) end, env)
      define_variable(:/, fn(operands, eval, env) -> divide(operands, eval, env) end, env)
  end

  defp add(operands, eval, env) do
    Enum.reduce(operands, 0, fn(x, acc) -> x + eval.(acc, env) end)
  end

  defp subtract([a | b], eval, env) do
    a - add(b, eval, env)
  end

  defp multiply(operands, eval, env) do
    Enum.reduce(operands, 1, fn(x, acc) -> x * eval.(acc, env) end)
  end

  defp divide([a | b], eval, env) do
    a / multiply(b, eval, env)
  end
end
