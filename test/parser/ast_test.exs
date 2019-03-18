defmodule AstTest do
  use ExUnit.Case

  alias Elisper.Parser.AST

  @tag :ignore
  test "tokens for simple expression gives valid CST" do
    tokens = ["(", "+", "1", "1", ")"]
    expected = ["+", "1", "1"]
    actual = AST.build(tokens)
    assert actual == expected
  end

  @tag :ignore
  test "tokens for nested expression gives nested CST" do
    tokens = ["(", "*", "x", "(", "+", "y", "1", ")", ")"]
    expected = ["*", "x", ["+", "y", "1"]]
    actual = AST.build(tokens)
    assert actual == expected
  end

  @tag :ignore
  test "tokens for complex expression gives valid CST" do
    tokens = ["(", "begin", "(", "define", "r", "10", ")", "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"]
    expected = ["begin", ["define", "r", "10"], [ "*", "pi", ["*", "r", "r"]]]
    actual = AST.build(tokens)
    assert actual == expected
  end

  @tag :ignore
  test "build raises TokenMissingError for empty token list" do
    tokens = []
    assert_raise TokenMissingError, fn -> CST.build(tokens) end
  end

  @tag :ignore
  test "build raises SyntaxError for invalid expression" do
    tokens = [")"]
    assert_raise Elisper.Parser.SyntaxError,
                 "Invalid expression syntax",
                 fn -> CST.build(tokens) end
  end

  @tag :ignore
  test "build raises SyntaxError for unterminated expression" do
    tokens = ["(", "x", "*", "(", "y", "+", "1", ")"]
    IO.inspect CST.build(tokens)
    assert_raise Elisper.Parser.SyntaxError,
    "Unterminated expression! Are you missing a ) ?",
    fn -> CST.build(tokens) end
  end

end
