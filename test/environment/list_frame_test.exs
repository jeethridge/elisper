defmodule ListFrameTest do
  use ExUnit.Case

  alias Elisper.Environment.ListFrame

  test "new builds a new frame" do
    variables = ["x", "y", "z"]
    values = [1, 2, 3]
    expected_frame = [["x", "y", "z"], [1, 2, 3]]
    frame = ListFrame.new(variables, values)
    assert frame == expected_frame
  end

  test "variables returns variables" do
    expected_variables = ["x", "y", "z"]
    frame = [["x", "y", "z"], [1, 2, 3]]
    variables = ListFrame.variables(frame)
    assert variables == expected_variables
  end

  test "values returns values" do
    expected_values = [1, 2, 3]
    frame = [["x", "y", "z"], [1, 2, 3]]
    values = ListFrame.values(frame)
    assert values == expected_values
  end

  test "bind adds new binding to frame" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    expected_frame = [["foo", "x", "y", "z"], ["bar", 1, 2, 3]]
    new_frame = ListFrame.bind("foo", "bar", frame)
    assert new_frame == expected_frame
  end

  test "find finds value when in frame" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    assert ListFrame.find("y", frame) == 2
  end

  test "find returns nil when not in frame" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    assert ListFrame.find("q", frame) == nil
  end

  test "replace returns updated frame with replaced value" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    expected = [["x", "y", "z"], [1, 17, 3]]
    assert ListFrame.replace("y", 17, frame) == expected
  end
end
