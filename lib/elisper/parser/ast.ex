defmodule Elisper.Parser.AST do
  @moduledoc """
  This module builds an abstract syntax tree from a token stream.
  """
  def build(tokens, ast) do
    build_ast(tokens, ast)
  end

  # No tokens to process, return the list
  def build_ast([], list) do
    {:ok, [], list}
  end

  # Start a new list with empty AST
  def build_ast(["(" | tokens], []) do
    build_ast(tokens, [])
  end

  # Add a new list to existing AST
  def build_ast(["(" | tokens], list) do
    {:ok, remaining_tokens, new_list } = build_ast(tokens, [])
    list = list ++ [new_list]
    build_ast(remaining_tokens, list)
  end

  # Finish a list
  def build_ast([")" | tokens], list) do
    {:ok, tokens, list}
  end

  # A list starting with a regular token appends a token to the list
  # and then keeps building
  def build_ast([token | rest], list) do
    list = list ++ [token]
    build_ast(rest, list)
  end

end
