defmodule TokenizeTest do
  use ExUnit.Case
  alias Elisper.Parser.Tokenizer

  test "tokenize gives list of tokens when valid" do
    program = "(begin (define r 10) (* 3.14 (* r r)))"

    expected = [
      "(",
      ":begin",
      "(",
      ":define",
      "r",
      10,
      ")",
      "(",
      ":*",
      3.14,
      "(",
      ":*",
      "r",
      "r",
      ")",
      ")",
      ")"
    ]

    actual = Tokenizer.tokenize(program)
    assert actual == expected
  end
end
