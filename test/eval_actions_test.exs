defmodule Elisper.MciTest do
  use ExUnit.Case
  import Elisper.EvalActions

  test "list of values returns list of values for single operator expression" do
    expression = [:+, 2, 3]
    values = list_of_values(exp, env)
    assert not self_evaluating?([:define, :x, 1])
  end

end
