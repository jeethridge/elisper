defmodule Elisper.EvalCondsTest do
  use ExUnit.Case
  import Elisper.EvalConds

  test "numbers and strings are self evaluating" do
    assert self_evaluating?(2.718)
    assert self_evaluating?("sally is a monster of a snake")
    assert not self_evaluating?([:define, :x, 1])
  end

  test "variables are atoms" do
    assert not variable?("hello")
    assert variable?(:hello)
  end

  test "quoted expressions start with quoted keyword" do
    assert quoted?([:quoted, "+ 1 1"])
    assert not quoted?([ "+ 1 1" ])
  end

  test "assignments have the form (set! <var> <val>)" do
    assert assignment?([:set!, :x, 100])
    assert not assignment?([:x, 100])
  end

  test "definitions can take the form (define <var> <val>)" do
    assert definition?([:define, :y, "hello"])
  end

  test "deinitions can take the form (define, (<var> <param₁> … <param>) <body>)" do
    assert definition?([:define, [:add, :x, :y], [:+, :x, :y]])
  end
end
