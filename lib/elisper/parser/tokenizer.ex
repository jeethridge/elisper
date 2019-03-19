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

  def mark_token(str) do
    cond do
      str in @op_chars -> token(str)
      str in @special_forms -> token(str)
      true -> primative(str)
    end
  end

  def token(str) do
    ":"<>str
  end

  def primative(str) do
    cond do
      is_numeric(str) ->
        {num, _} = Float.parse(str)
        num
      true -> str
    end
  end

  def is_numeric(str) do
    case Float.parse(str) do
      {_num, ""} -> true
      _          -> false
    end
  end

end
