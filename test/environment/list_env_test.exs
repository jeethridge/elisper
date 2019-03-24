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

  test "frame_variables returns variables" do
    expected_variables = ["x", "y", "z"]
    frame = [["x", "y", "z"], [1, 2, 3]]
    variables = ListEnv.frame_variables(frame)
    assert variables == expected_variables
  end

  test "frame_values returns values" do
    expected_values = [1, 2, 3]
    frame = [["x", "y", "z"], [1, 2, 3]]
    values = ListEnv.frame_values(frame)
    assert values == expected_values
  end

  test "add binding adds new binding to frame" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    expected_frame = [["foo", "x", "y", "z"], ["bar", 1, 2, 3]]
    new_frame = ListEnv.add_binding_to_frame("foo", "bar", frame)
    assert new_frame == expected_frame
  end

end
