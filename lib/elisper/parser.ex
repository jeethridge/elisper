defmodule Elisper.Parser do
  @moduledoc """
  Defines the parsing operations required for the interpreter to work.
  """

  @doc """
  Read a schem expression from a string.
  """
  def parse(program), do: nil

  @doc """
  Convert a string of characters into a list of tokens.
  """
  def tokenize(str) do
    str
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
  end

  @doc """
  Read an expression from a sequence of tokens.
  """
  def read_from_tokens([]), do: raise TokenMissingError
  def read_from_tokens(list), do: nil

  @doc """
  Numbers are numbers, all other tokens are symbols
  """
  def atom(str), do: nil

end
