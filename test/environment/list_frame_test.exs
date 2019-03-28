defmodule ListFrameTest do
  use ExUnit.Case

  alias Elisper.Environment.ListFrame

  test "make_frame builds a pair of lists" do
    variables = ["x", "y", "z"]
    values = [1, 2, 3]
    expected_frame = [["x", "y", "z"], [1, 2, 3]]
    frame = ListFrame.make_frame(variables, values)
    assert frame == expected_frame
  end

  test "frame_variables returns variables" do
    expected_variables = ["x", "y", "z"]
    frame = [["x", "y", "z"], [1, 2, 3]]
    variables = ListFrame.frame_variables(frame)
    assert variables == expected_variables
  end

  test "frame_values returns values" do
    expected_values = [1, 2, 3]
    frame = [["x", "y", "z"], [1, 2, 3]]
    values = ListFrame.frame_values(frame)
    assert values == expected_values
  end

  test "add binding adds new binding to frame" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    expected_frame = [["foo", "x", "y", "z"], ["bar", 1, 2, 3]]
    new_frame = ListFrame.add_binding_to_frame("foo", "bar", frame)
    assert new_frame == expected_frame
  end

  test "find_in_frame finds value when in frame" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    assert ListFrame.find_in_frame("y", frame) == 2
  end

  test "find_in_frame returns nil when not in frame" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    assert ListFrame.find_in_frame("q", frame) == nil
  end

  test "replace in frame returns updated frame" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    expected = [["x", "y", "z"], [1, 17, 3]]
    assert ListFrame.replace_in_frame("y", 17, frame) == expected
  end

  test "add_binding_to_frame adds new binding" do
    var = "x"
    val = 3.14
    frame = [["hello"], ["world"]]
    expected_frame = [["x", "hello"], [3.14, "world"]]
    assert ListFrame.add_binding_to_frame(var, val, frame) == expected_frame
  end

end
