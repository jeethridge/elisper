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
end
