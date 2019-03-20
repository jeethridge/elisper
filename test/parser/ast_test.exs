defmodule AstTest do
  use ExUnit.Case

  alias Elisper.Parser.AST

  test "tokens for simple expression gives valid AST" do
    tokens = [":+", 1, 1]
    expected = [":+", 1, 1]
    actual = AST.build(tokens, [])
    assert actual == expected
  end

  test "tokens for simple list expression gives valid AST" do
    tokens = ["(", ":+", 1, 1, ")"]
    expected = [":+", 1, 1]
    actual = AST.build(tokens, [])
    assert actual == expected
  end

  test "tokens for nested expression gives valid AST" do
    tokens = ["(", ":*", 3, "(", ":+", 2, 1, ")", ")"]
    expected = [":*", 3, [":+", 2, 1]]
    actual = AST.build(tokens, [])
    assert actual == expected
  end

  test "tokens for complex expression gives valid CST" do
    tokens = [
      "(",
      ":begin",
      "(",
      ":define",
      "r",
      10,
      ")",
      "(",
      ":*",
      "pi",
      "(",
      ":*",
      "r",
      "r",
      ")",
      ")",
      ")"
    ]

    expected = [":begin", [":define", "r", 10], [":*", "pi", [":*", "r", "r"]]]
    actual = AST.build(tokens, [])
    assert actual == expected
  end

end
