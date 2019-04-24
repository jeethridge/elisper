defmodule Elisper.Parser.Tokenizer do
  @moduledoc """
  Tokenizer for the Elisper Parser.

  Note: Works for simple strings like "foo"
  but not compound or delimited strings like "the quick brown fox"
  or "the \"quick\" brown fox". Will need to come back and build a
  better tokenizer for that.
  """
  alias Elisper.Grammar

  def tokenize(buffer) do
    buffer
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
    |> Enum.map(&token/1)
  end

  def token("("), do: "("
  def token(")"), do: ")"
  def token(raw) do
    cond do
      is_string(raw) -> String.replace(raw,~s("),"")
      is_numeric(raw) -> Float.parse(raw) |> elem(0)
      true -> Code.string_to_quoted(":" <> raw) |> elem(1)
    end
  end

  def is_numeric(raw) do
    case Float.parse(raw) do
      {_, ""} -> true
      _ -> false
    end
  end

  def is_string(raw) do
    raw =~ ~r/\".*\"/
  end
end
