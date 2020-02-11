defmodule Elisper do
  @moduledoc """
  Top-level API for the Elisper interpreter.
  """
  alias Elisper.Driver
  defdelegate repl(), to: Driver
end
