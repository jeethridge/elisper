defmodule Elisper.Parser.Tokenizer do
  @moduledoc """
  Tokenizer for the Elisper Parser.
  """
  alias Elisper.Grammar

  def tokenize(str) do
    str
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
    |> Enum.map(&mark_token/1)
  end

  def mark_token(str) do
    cond do
      str in Grammar.strings() -> token(str)
      true -> primative(str)
    end
  end

  def token(str) do
    {:ok, token} = Code.string_to_quoted(":" <> str)
    token
  end

  def primative(str) do
    cond do
      is_numeric(str) ->
        {num, _} = Float.parse(str)
        num

      true ->
        str
    end
  end

  def is_numeric(str) do
    case Float.parse(str) do
      {_num, ""} -> true
      _ -> false
    end
  end
end
