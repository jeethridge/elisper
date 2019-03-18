defmodule Elisper.Parser.Tokenizer do
@moduledoc """
Tokenizer for the Elisper Parser.
"""
  @op_chars ["+", "-", "*", "/", "%", "=", "&", "|", "<", ">", "!", "'"]
  @special_forms ["begin", "define", "if"]

  def tokenize(str) do
    str
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
    |> Enum.map(&mark_token/1)
  end

  def mark_token(char) do
    cond do
      char in @op_chars -> token(char)
      char in @special_forms -> token(char)
      true -> char
    end
  end

  def token(char) do
    ":"<>char
  end

end
