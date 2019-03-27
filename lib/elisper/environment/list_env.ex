defmodule Elisper.Environment.ListEnv do
  @moduledoc """
  Provides a concrete implementation of the Environment API using linked lists to build environments.
  This implementation is far from optimal but closely represents the implementation in SICP.
  """
  alias Elisper.Environment.UnboundVariableError

  # Returns the global environment
  def global(), do: empty()

  # The empty environment
  def empty(), do: []

  # Return the value bound to the symbol
  def lookup_variable_value(variable, []), do: raise(UnboundVariableError)

  def lookup_variable_value(variable, env) do
    frame = first_frame(env)
    result = find_in_frame(variable, frame)

    case result do
      nil -> lookup_variable_value(variable, enclosing_environment(env))
      _ -> result
    end
  end

  # Bind the variable in the environment to the new value - error if variable unbound
  def set_variable_value(variable, _, []), do: {:unbound, []}

  def set_variable_value(variable, value, env) do
    [frame, rest] = env
    result = find_in_frame(variable, frame)

    case result do
      nil ->
        {result, env} = set_variable_value(variable, value, enclosing_environment(env))
        {result, [frame, env]}

      _ ->
        updated_frame = replace_in_frame(variable, value, frame)
        {:ok, [updated_frame, rest]}
    end
  end

  # Return a new environment consisting of a new frame with the variables bound to the values
  def extend_environment(variables, values, _) when length(variables) != length(values),
    do: raise(UnboundVariableError)

  def extend_environment(variables, values, base_env),
    do: [make_frame(variables, values), base_env]

  # Define a new variable or update if variable already bound
  def define_variable(variable, value, [first_frame, enclosing] = env) do
    {result, env} = set_variable_value(variable, value, env)

    case result do
      :unbound -> [add_binding_to_frame(variable, value, first_frame), enclosing]
      :ok -> env
    end
  end

  # The following are helper operations that allow us to represent the environment as a list of frames

  # The enclosing env of an env is the rest tail of the list
  def enclosing_environment([_, enclosing]), do: enclosing

  # The first frame is the head of the list
  def first_frame([first_frame, _]), do: first_frame

  # Each frame is a pair of lists
  def make_frame(variables, values), do: [variables, values]

  # Get the variables in a frame
  def frame_variables([variables, _]), do: variables

  # Get the values in a fram
  def frame_values([_, values]), do: values

  # Add a new binding to a frame
  def add_binding_to_frame(variable, value, []), do: [[variable], [value]]

  def add_binding_to_frame(variable, value, frame) do
    [[variable] ++ frame_variables(frame), [value] ++ frame_values(frame)]
  end

  # Try to find a variable value in the frame
  def find_in_frame(var, frame) do
    vars = frame_variables(frame)
    idx = Enum.find_index(vars, fn item -> item == var end)

    if idx != nil do
      {:ok, val} = Enum.fetch(frame_values(frame), idx)
      val
    end
  end

  # Try to replace a variable value in the frame
  def replace_in_frame(var, val, [vars, vals]) do
    tframe =
      Enum.zip(vars, vals)
      |> Enum.map(fn binding ->
        cond do
          elem(binding, 0) == var -> {var, val}
          true -> binding
        end
      end)
      |> Enum.unzip()

    [elem(tframe, 0), elem(tframe, 1)]
  end
end
