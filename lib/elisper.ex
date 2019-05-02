defmodule Elisper do
  @moduledoc """
  API for the Elisper interpreter.
  """
  alias Elisper.MCI
  defdelegate evaluate(expression), to: MCI
end
