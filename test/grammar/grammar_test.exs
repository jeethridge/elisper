defmodule GrammarTest do
  use ExUnit.Case

  alias Elisper.Grammar
  test "strings returns tokens in grammar as list of strings" do
    some_valid_grammar = ["+", "-", "begin", "define"]
    grammar_strings = Grammar.strings()
    assert Enum.map(some_valid_grammar, fn str -> str in grammar_strings end)
           |> Enum.reduce(true, fn in_grammar?, acc -> in_grammar? and acc end)
  end

end
