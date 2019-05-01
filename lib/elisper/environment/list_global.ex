defmodule Elisper.Environment.ListGlobal do
  @moduledoc """
  Defines the global environement for list-based environments.
  """
  import Elisper.Environment.ListFrame

  def init(env) do
    # Define addition
    bind(
      :+,
      fn(operands, eval) -> Enum.reduce(operands, 0, fn(x, acc) -> x + eval.(acc) end) end,
      env)
  end


end
