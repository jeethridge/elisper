defmodule Elisper.Parser.AST do
  @moduledoc """
  This module is responsible for building the abstract syntax tree from a token stream.

  ## TODO -- we're almost there! The issue with this approach is that we want
  tokens to act like a "peristent" stack that we can pop off of while
  we append on to list.
  """
  defstruct [:tokens, :tree]

  # No tokens to process, return the list
  def build([], list) do
    IO.inspect list
    list
  end

  # Start a new list with empty AST
  def build(["(" | tokens], []) do
    IO.puts("Start list")
    list = build(tokens, [])
  end

  # Add a new list to existing AST
  def build(["(" | tokens], list) do
    list = list ++ [build(tokens, [])]
    build(tokens, list)
  end

  # Finish a list
  def build([")" | tokens], list) do
    IO.puts("End list")
    list
  end

  # A list starting with a regular token appends a token to the list
  # and then keeps building
  def build([token | rest], list) do
    IO.puts("Processing token #{token}")
    list = list ++ [token]
    build(rest, list)
  end

end
