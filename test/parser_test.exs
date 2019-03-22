defmodule ParserTest do
  use ExUnit.Case

  alias Elisper.Parser

  test "a valid scheme expression results in a valid AST" do
    expression = "(begin (define x 10) (* 3 ( + x 10 ))"
    expected = [":begin", [":define", "x", 10], [":*", 3, [":+", "x", 10]]]
    ast = Parser.parse(expression)
    assert ast == expected
  end
end
