defmodule Elisper.Parser do
  @moduledoc """
  Defines the parsing operations for the interpreter
  """
  alias Elisper.Parser.Parser, as: ParserImpl

  @doc """
  Parse a scheme expression.
  """
  defdelegate parse(program), to: ParserImpl

end
