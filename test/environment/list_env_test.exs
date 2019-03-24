defmodule ListEnvTest do
  use ExUnit.Case

  alias Elisper.Environment.ListEnv

  test "empty environment is empty list" do
    assert ListEnv.empty == []
  end

  test "make_frame builds a pair of lists" do
    variables = ["x", "y", "z"]
    values = [1, 2, 3]
    expected_frame = [["x", "y", "z"], [1, 2, 3]]
    frame = ListEnv.make_frame(variables, values)
    assert frame == expected_frame
  end

end
