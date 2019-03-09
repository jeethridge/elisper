defmodule Elisper.Parser.CST do
@moduledoc """
 Here we define some functions to build our concrete syntax tree (parse tree) from the grammar.
"""
  def build([]), do: raise TokenMissingError
  def build([ ")" ]), do: raise RuntimeError, message: "Expression must not start with )"

  # Start a new program
  def build([ "(" | tokens ]) do
    build(tokens, length(tokens))
  end

  # Start a new expression
  def build([ "(" | tokens ], n) do
    [ build(tokens, (n-1) ) ]
  end

  # Terminate a program or expression
  def build([ ")" | _ ], _) do
    []
  end

  # Parse the next token
  def build(tokens, n) do
    [ head | tail ] = tokens
    [atom(head) | build(tail, (n-1))]
  end

  def atom(token) do
    token
  end

end
