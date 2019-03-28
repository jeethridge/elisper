defmodule Elisper.Environment.ListEnv do
  @moduledoc """
  Provides a concrete implementation of the Environment API.

  This implementation is far from optimal but
  resembles the implementation in SICP using linked lists.
  """
  alias Elisper.Environment.UnboundVariableError
  alias Elisper.Environment.ListFrame, as: Frame

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
    result = Frame.find_in_frame(variable, frame)

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
    result = Frame.find_in_frame(variable, frame)

    case result do
      nil ->
        {result, env} = set_variable_value(variable, value, enclosing_environment(env))
        {result, [frame, env]}

      _ ->
        updated_frame = Frame.replace_in_frame(variable, value, frame)
        {:ok, [updated_frame, enclosing]}
    end
  end

  @doc """
  Returns a new environment containing a new frame with the variables bound to the values.
  """
  def extend_environment(variables, values, _) when length(variables) != length(values),
    do: raise(UnboundVariableError)

  def extend_environment(variables, values, env),
    do: [Frame.make_frame(variables, values), env]

  @doc """
  Defines a new variable or update if variable already bound
  """
  def define_variable(variable, value, [first_frame, enclosing] = env) do
    {result, env} = set_variable_value(variable, value, env)

    case result do
      :unbound -> [Frame.add_binding_to_frame(variable, value, first_frame), enclosing]
      :ok -> env
    end
  end

  defp enclosing_environment([_, enclosing]), do: enclosing
  defp first_frame([first_frame, _]), do: first_frame

end
