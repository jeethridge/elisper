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
  def repl() do
    program = IO.gets "elisper>"
    IO.puts Elisper.evaluate(Elisper.Parser.parse(program))
    repl()
  end
end
