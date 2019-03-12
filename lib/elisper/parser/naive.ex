defmodule Elisper.Parser.Naive do
  @moduledoc """
  Defines the parsing operations required for the interpreter to work.
  """

  # Non grammar elements to be removed by the lexer
  @non_grammar ["[" , " ", "]"]


  def parse(str) do
    nil
  end

  def pre_format(str) do
    str
    |> String.replace("(", " [ ")
    |> String.replace(")", " ] ")
    |> String.split()
    |> mark_tokens
  end

  def mark_tokens(list) do
    Enum.map(list, &mark_token/1)
  end

  def mark_token(token) when token in @non_grammar do
    token
  end

  def mark_token(token) do
    "'#{token}"
  end
end
