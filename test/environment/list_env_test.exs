defmodule ListEnvTest do
  use ExUnit.Case

  alias Elisper.Environment.ListEnv
  alias Elisper.Environment.UnboundVariableError

  test "empty environment is empty list" do
    assert ListEnv.empty() == []
  end

  # TODO might not want this to live under ListEnv.
  test "global environment not empty" do
    assert [] != ListEnv.global()
  end

  test "extend environment appends new frame to current environment" do
    base_environment = []
    vars = ["x"]
    vals = [1]
    new_frame = [vars, vals]
    expected_environment = [new_frame, base_environment]
    new_environment = ListEnv.extend_environment(vars, vals, base_environment)
    assert new_environment == expected_environment
  end

  test "extend environment signals error if the number of vars and vals don't match" do
    vars = ["x", "y"]
    vals = [1]
    assert_raise UnboundVariableError, fn -> ListEnv.extend_environment(vars, vals, []) end
  end

  test "lookup variable raises unbound variable error when empty env" do
    env = []
    var = "x"
    assert_raise UnboundVariableError, fn -> ListEnv.lookup_variable_value(var, env) end
  end

  test "lookup variable finds variable when in first frame" do
    var = "x"
    val = 1
    env = [[[var], [val]], []]
    actual = ListEnv.lookup_variable_value(var, env)
    assert actual == val
  end

  test "lookup variable finds variable when not in first frame" do
    var = "x"
    val = 1
    first_frame = [["foo"], ["bar"]]
    next_frame = [[var], [val]]
    base_env = [next_frame, []]
    env = [first_frame, base_env]
    actual = ListEnv.lookup_variable_value(var, env)
    assert actual == val
  end

  test "set variable value returns none when variable doesn't exist" do
    env = []
    var = "x"
    {result, updated_env} = ListEnv.set_variable_value(var, 0, env)
    assert result == :unbound
    assert updated_env == env
  end

  test "set variable value returns updated environment when success" do
    var = "x"
    val = 2
    first_frame = [["foo"], ["bar"]]
    base_env = [[[var], [1]], []]
    expected_base_env = [[[var], [val]], []]
    env = [first_frame, base_env]
    expected_env = [first_frame, expected_base_env]
    {result, updated_env} = ListEnv.set_variable_value(var, val, env)
    assert updated_env == expected_env
    assert result == :ok
  end

  test "define variable updates variable if vaiable already bound" do
    var = "x"
    val = 2
    first_frame = [["foo"], ["bar"]]
    base_env = [[[var], [1]], []]
    expected_base_env = [[[var], [val]], []]
    env = [first_frame, base_env]
    expected_env = [first_frame, expected_base_env]
    updated_env = ListEnv.define_variable(var, val, env)
    assert updated_env == expected_env
  end

  test "define variable adds variable to first frame when unbound in environment" do
    var = "job"
    val = "SRE"
    first_frame = [["name"], ["Jill"]]
    env = [first_frame, []]
    expected_env = [[["job", "name"], ["SRE", "Jill"]], []]
    assert ListEnv.define_variable(var, val, env) == expected_env
  end
end
