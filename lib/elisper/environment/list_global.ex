defmodule Elisper.Environment.ListGlobal do
  @moduledoc """
  Defines the global environement for list-based environments.
  """
  import Elisper.Environment.ListEnv
  import Elisper.Environment.ListFrame

  def init() do
    # Define addition
      define_variable(
        :+,
        fn(operands, eval, env) -> Enum.reduce(operands, 0, fn(x, acc) -> x + eval.(acc, env) end) end,
        # TODO this is a bit wonky, shouldn't have to bootstrap environment this way
        # methinks the empty environment definition is wrong.
        [bind(nil, nil, []),[]])
  end


end
