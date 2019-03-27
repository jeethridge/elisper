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

 test "extend environment signals error if the number of vars and vals don't match" do
    vars = ["x", "y"]
    vals = [1]
    assert_raise UnboundVariableError, fn -> ListEnv.extend_environment(vars, vals, []) end
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

  test "set variable value returns none when variable doesn't exist" do
    env = []
    var = "x"
    { result, updated_env } = ListEnv.set_variable_value(var, 0, env)
    assert result == :unbound
    assert updated_env == env
  end

  test "replace in frame returns updated frame" do
    frame = [["x", "y", "z"], [1, 2, 3]]
    expected  = [["x", "y", "z"], [1, 17, 3]]
    assert ListEnv.replace_in_frame("y", 17, frame) == expected
  end

  test "set variable value returns updated environment when success" do
    var = "x"
    val = 2
    first_frame = [ ["foo"], ["bar"] ]
    base_env = [ [ [var], [1] ], [] ]
    expected_base_env = [ [ [var], [val] ], [] ]
    env = [ first_frame , base_env  ]
    expected_env = [ first_frame , expected_base_env ]
    { result, updated_env } = ListEnv.set_variable_value(var, val, env)
    assert updated_env == expected_env
    assert result == :ok
  end

  test "add_binding_to_frame adds new binding" do
    var = "x"
    val = 3.14
    frame = [ ["hello"], ["world"] ]
    expected_frame = [ ["x", "hello"], [3.14, "world"] ]
    assert ListEnv.add_binding_to_frame(var, val, frame) == expected_frame
  end

  test "define variable updates variable if vaiable already bound" do
    var = "x"
    val = 2
    first_frame = [ ["foo"], ["bar"] ]
    base_env = [ [ [var], [1] ], [] ]
    expected_base_env = [ [ [var], [val] ], [] ]
    env = [ first_frame , base_env ]
    expected_env = [ first_frame , expected_base_env ]
    updated_env = ListEnv.define_variable(var, val, env)
    assert updated_env == expected_env
  end

  test "define variable adds variable to first frame when unbound in environment" do
    var = "job"
    val = "SRE"
    first_frame = [ ["name"], ["Jill"] ]
    env = [ first_frame, [] ]
    expected_env = [ [["job", "name"], ["SRE", "Jill"]] , [] ]
    assert ListEnv.define_variable(var, val, env) == expected_env
  end

end
