defmodule ParserTest do
  use ExUnit.Case

  alias Elisper.Parser

  test "tokenize gives list of tokens when valid" do
    program = "(begin (define r 10) (* pi (* r r)))"
    expected = ["(", "begin", "(", "define", "r", "10", ")", "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"]
    actual = Parser.tokenize(program)
    assert actual == expected
  end

  test "read_from_tokens raises TokenMissingError for zero length list" do
    tokens = []
    assert_raise TokenMissingError, fn -> Parser.read_from_tokens(tokens) end
  end

  test "read_from_tokens raises SyntaxError for leading )" do
    tokens = [")"]
    assert_raise RuntimeError,
                 "Expression must not start with (",
                 fn -> Parser.read_from_tokens(tokens) end
  end

end
