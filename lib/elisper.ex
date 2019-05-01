defmodule Elisper do
  @moduledoc """
  API for the Elisper interpreter.
  """
  alias Elisper.MCI
  defdelegate eval(exp, env), to: MCI
end
