defmodule CstTest do
  use ExUnit.Case

  alias Elisper.Parser.CST

  test "tokens for simple expression gives valid CST" do
    tokens = ["(", "x", "+", "1", ")"]
    expected = ["x", "+", "1"]
    actual = CST.build(tokens)
    assert actual == expected
  end

  test "tokens for nested expression gives nested CST" do
    tokens = ["(", "x", "*", "(", "y", "+", "1", ")", ")"]
    expected = ["x", "*", ["y", "+", "1"]]
    actual = CST.build(tokens)
    assert actual == expected
  end

  test "build raises TokenMissingError for empty token list" do
    tokens = []
    assert_raise TokenMissingError, fn -> CST.build(tokens) end
  end

  test "build raises SyntaxError for leading )" do
    tokens = [")"]
    assert_raise RuntimeError,
                 "Expression must not start with )",
                 fn -> CST.build(tokens) end
  end

end
