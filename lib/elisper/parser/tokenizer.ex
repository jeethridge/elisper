defmodule Elisper.Parser.Tokenizer do
@moduledoc """
Tokenizer for the Elisper Parser.
"""
  def tokenize(str) do
    str
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
  end

end
