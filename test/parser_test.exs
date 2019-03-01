defmodule ParserTest do
  use ExUnit.Case

  alias Elisper.Parser

  test "tokenize gives list of tokens when valid" do
    program = "(begin (define r 10) (* pi (* r r)))"
    expected = ["(", "begin", "(", "define", "r", "10", ")", "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"]
    actual = Parser.tokenize(program)
    assert actual == expected
  end


end
