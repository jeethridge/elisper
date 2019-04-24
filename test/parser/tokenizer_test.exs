defmodule TokenizeTest do
  use ExUnit.Case
  alias Elisper.Parser.Tokenizer

  test "tokenize gives list of tokens when valid without strings" do
    program = "(begin (define r 10) (* 3.14 (* r r)))"

    expected = [
      "(",
      :begin,
      "(",
      :define,
      :r,
      10,
      ")",
      "(",
      :*,
      3.14,
      "(",
      :*,
      :r,
      :r,
      ")",
      ")",
      ")"
    ]

    actual = Tokenizer.tokenize(program)
    assert actual == expected
  end

  test "tokenize gives list of tokens when valid with strings" do
    program = "(begin (define x \"foo\"))"
    expected  = ["(", :begin, "(", :define, :x, "foo", ")", ")"]

    actual = Tokenizer.tokenize(program)
    assert actual == expected
  end
end
