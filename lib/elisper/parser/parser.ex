defmodule Elisper.Parser.Parser do
  @moduledoc """
  Defines the parsing operations required for the interpreter to work.
  """
  alias Elisper.Parser.Tokenizer
  alias Elisper.Parser.AST
  @doc """
  Reads a scheme expression from a string and returns the abstract syntax tree.
  """
  def parse(program) do
    {:ok, [], ast} = program |> Tokenizer.tokenize() |> AST.build([])
    ast
  end
end
