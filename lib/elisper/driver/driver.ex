defmodule Elisper.Driver do
  @moduledoc """
  Defines the IO Driver functions for use by the Elisper interprter.
  """

  @doc """
  Runs the repl loop for Elisper.

  ## Examples

   iex> Elisper.Driver.repl(&IO.inspect(&1))

   iex> Elisper.Driver.repl(&Elisper.evaluate(&1))
  """
  def repl(run) do
    prog = IO.gets "elisper>"
    run.(prog)
    repl(run)
  end
end
