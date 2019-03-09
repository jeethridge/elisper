defmodule Elisper.Parser do
  alias Elisper.CST
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
end
