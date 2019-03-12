defmodule Elisper.Parser do
  @moduledoc """
  Defines the parsing operations required for the interpreter to work.
  """
  alias Elisper.Parser.Naive, as: NaiveParser

  @doc """
  Read a schem expression from a string.
  """
  defdelegate parse(program), to: NaiveParser

end
