defmodule Elisper.Driver do
  @moduledoc """
  Defines the IO Driver functions for use by the Elisper interprter.
  """

  @doc """
  Runs the repl loop for Elisper.

  ## Examples

   iex> Elisper.Driver.repl(nil, &IO.inspect(&1))

   iex> Elisper.Driver.repl(Elisper.Environment.global(), &Elisper.evaluate(&1))
  """
  def repl(env \\ nil, run) do
    prog = IO.gets "elisper>"
    run.(prog)
    repl(env, run)
  end
end
