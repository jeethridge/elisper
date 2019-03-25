defmodule ListEnvTest do
  use ExUnit.Case

  alias Elisper.Environment.ListEnv
  alias Elisper.Environment.UnboundVariableError

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

 test "extend environment appends new frame to current environment" do
    base_environment = []
    vars = [ "x" ]
    vals = [ 1 ]
    new_frame = [ vars , vals ]
    expected_environment = [ new_frame , base_environment ]
    new_environment = ListEnv.extend_environment(vars, vals, base_environment)
    assert new_environment == expected_environment
 end

 # TODO error handling things
 @tag :ignore
 test "extend environment signals error if the number of vars and vals don't match" do
    base_environment = []
    vars = ["x, y"]
    vals = [1]
    assert_raise UnboundVariableError, ListEnv.extend_environment(vars, vals, base_environment)
 end

 test "find_in_frame finds value when in frame" do
  frame = [["x", "y", "z"], [1, 2, 3]]
  assert ListEnv.find_in_frame("y", frame) == 2
 end

 test "find_in_frame returns nil when not in frame" do
  frame = [["x", "y", "z"], [1, 2, 3]]
  assert ListEnv.find_in_frame("q", frame) == nil
 end

 test "first_frame returns first frame" do
  first_frame = [["x"], [1]]
  enclosing = [["y"], [2]]
  env = [ first_frame  , enclosing ]
  assert ListEnv.first_frame(env) == first_frame
 end

 test "enclosing_environment returns enclosing" do
  first_frame = [["x"], [1]]
  enclosing = [["y"], [2]]
  env = [ first_frame  , enclosing ]
  assert ListEnv.enclosing_environment(env) == enclosing
 end

  test "lookup variable raises unbound variable error when empty env" do
    env = []
    var = "x"
    assert_raise UnboundVariableError, fn -> ListEnv.lookup_variable_value(var, env) end
  end

  test "lookup variable finds variable when in first frame" do
    var = "x"
    val = 1
    env = [ [[var],[val]], [] ]
    actual = ListEnv.lookup_variable_value(var, env)
    assert actual == val
  end

  test "lookup variable finds variable when not in first frame" do
    var = "x"
    val = 1
    first_frame = [ ["foo"], ["bar"] ]
    next_frame = [ [var], [val] ]
    base_env = [ next_frame, [] ]
    env = [ first_frame , base_env  ]
    actual = ListEnv.lookup_variable_value(var, env)
    assert actual == val
  end

end
