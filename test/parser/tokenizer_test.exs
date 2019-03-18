defmodule TokenizeTest do
  use ExUnit.Case

  alias Elisper.Parser.Tokenizer

  @ignore
  test "tokenize gives list of tokens when valid" do
    program = "(begin (define r 10) (* pi (* r r)))"
    expected = ["(", ":begin", "(", ":define", "r", "10", ")", "(", ":*", "pi", "(", ":*", "r", "r", ")", ")", ")"]
    actual = Tokenizer.tokenize(program)
    assert actual == expected
  end

  test "mark token marks expected opchars" do
    tokens = ["+", "-", "*"]
    expected = [":+", ":-", ":*"]
    actual = tokens |> Enum.map(&Tokenizer.mark_token/1)
    assert actual == expected
  end
end
