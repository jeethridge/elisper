defmodule GrammarTest do
  use ExUnit.Case

  alias Elisper.Grammar

  test "primatives are identified by the grammar" do
    some_primatives = [:+, :-, :*]
    grammar_primatives = Grammar.primatives()
    assert Enum.map(some_primatives, fn atom -> atom in grammar_primatives end)
           |> Enum.reduce(true, fn primative?, acc -> primative? and acc end)
  end
end
