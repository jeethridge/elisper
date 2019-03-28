defmodule Elisper.EvalCondsTest do
  use ExUnit.Case
  import Elisper.EvalConds

  test "numbers and strings are self evaluating" do
    assert self_evaluating?(2.718) == true
    assert self_evaluating?("sally is a monster of a snake") == true
    assert self_evaluating?([:define, :x, 1]) == false
  end

  test "variables are atoms" do
    assert variable?("hello") == false
    assert variable?(:hello) == true
  end
end
