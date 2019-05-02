defmodule Elisper.Environment do
  @moduledoc """
  Defines the environment API for Elisper.
  """
  alias Elisper.Environment.ListEnv
  alias Elisper.Environment.ListGlobal

  # Get the global environment
  defdelegate global(), to: ListGlobal, as: :init

  # Return the value bound to the symbol
  defdelegate lookup_variable_value(variable, env), to: ListEnv

  # Return a new environment consisting of a new frame with the variables bound to the values
  defdelegate extend_environment(varables, values, base_env), to: ListEnv

  # Add a new binding to the first frame in the environment
  defdelegate define_variable(variable, value, env), to: ListEnv

  # Bind the variable in the environment to the new value - error if variable unbound
  defdelegate set_variable_value(variable, value, env), to: ListEnv
end
