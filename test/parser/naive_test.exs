defmodule NaiveTest do
  use ExUnit.Case

  alias Elisper.Parser.Naive

  test "string for simple expression gives valid tokens" do
    expr = "(+ 1 1)"
    expected = ["+", "1", "1"]
    actual = Naive.parse(tokens)
    assert actual == expected
  end

  test "string for nested expression gives valid tokens" do
    tokens = "(* 2 (+ 1 3))"
    expected = ["*", "2", ["+", "1", "3"]]
    actual = Naive.parse(tokens)
    assert actual == expected
  end

  test "string for complex expression gives valid token" do
    tokens = "(begin (define r 10) (* pi (* r r)))"
    expected = ["begin", ["define", "r", "10"], [ "*", "pi", ["*", "r", "r"]]]
    actual = Naive.parse(tokens)
    assert actual == expected
  end

end
