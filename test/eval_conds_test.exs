defmodule Elisper.EvalCondsTest do
  use ExUnit.Case
  import Elisper.EvalConds

  test "self evaluating true for number and string" do
    assert self_evaluating?(2.718) == true
    assert self_evaluating?("sally is a monster of a snake") == true
    assert self_evaluating?([:define, "x", 1]) == false
  end
end
