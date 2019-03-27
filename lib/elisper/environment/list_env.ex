defmodule Elisper.Environment.ListEnv do
  @moduledoc """
  Provides a concrete implementation of the Environment API.

  This implementation is far from optimal but
  resembles the implementation in SICP using linked lists.
  """
  alias Elisper.Environment.UnboundVariableError

  @doc """
  Get an empty environment.
  """
  def empty(), do: []

  @doc """
  Looks up the specified variable in the supplied environment.
  """
  def lookup_variable_value(_, []), do: raise(UnboundVariableError)

  def lookup_variable_value(variable, env) do
    frame = first_frame(env)
    result = find_in_frame(variable, frame)

    case result do
      nil -> lookup_variable_value(variable, enclosing_environment(env))
      _ -> result
    end
  end

  @doc """
  Binds the variable in the environment to the new value.

  Returns:
    - {:unboud, env} when variable is unbound
    - {:ok, env} when variable set successfully
  """
  def set_variable_value(_, _, []), do: {:unbound, []}

  def set_variable_value(variable, value, env) do
    [frame, enclosing] = env
    result = find_in_frame(variable, frame)

    case result do
      nil ->
        {result, env} = set_variable_value(variable, value, enclosing_environment(env))
        {result, [frame, env]}

      _ ->
        updated_frame = replace_in_frame(variable, value, frame)
        {:ok, [updated_frame, enclosing]}
    end
  end

  @doc """
  Returns a new environment containing a new frame with the variables bound to the values.
  """
  def extend_environment(variables, values, _) when length(variables) != length(values),
    do: raise(UnboundVariableError)

  def extend_environment(variables, values, env),
    do: [make_frame(variables, values), env]

  @doc """
  Defines a new variable or update if variable already bound
  """
  def define_variable(variable, value, [first_frame, enclosing] = env) do
    {result, env} = set_variable_value(variable, value, env)

    case result do
      :unbound -> [add_binding_to_frame(variable, value, first_frame), enclosing]
      :ok -> env
    end
  end

  @doc """
    Gets the "enclosing" environment consisting of all trailing frames.
  """
  def enclosing_environment([_, enclosing]), do: enclosing

  @doc """
    Gets the first frame in the supplied environment.
  """
  def first_frame([first_frame, _]), do: first_frame

  @doc """
  Makes a new frame given a list varaibles and a list of values to be bound.
  """
  def make_frame(variables, values), do: [variables, values]

  @doc """
  Gets the list of variables in the specified frame.
  """
  def frame_variables([variables, _]), do: variables

  @doc """
  Gets the list of bound values in the specified frame.
  """
  def frame_values([_, values]), do: values

  @doc """
  Adds a new variable binding to a frame.
  """
  def add_binding_to_frame(variable, value, []), do: [[variable], [value]]

  def add_binding_to_frame(variable, value, frame) do
    [[variable] ++ frame_variables(frame), [value] ++ frame_values(frame)]
  end

  @doc """
  Tries to find the value bound to specified variable in the supplied frame.
  """
  def find_in_frame(var, frame) do
    vars = frame_variables(frame)
    idx = Enum.find_index(vars, fn item -> item == var end)

    if idx != nil do
      {:ok, val} = Enum.fetch(frame_values(frame), idx)
      val
    end
  end

  @doc """
  Tries to replace a variable value in the supplied frame.
  """
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
