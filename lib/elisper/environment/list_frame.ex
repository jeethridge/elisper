defmodule Elisper.Environment.ListFrame do
  @moduledoc """
  Defines operations on list-based frames.
  """

  @doc """
  Makes a new frame given a list varaibles and a list of values to be bound.
  """
  def new(variables, values), do: [variables, values]

  @doc """
  Gets the list of variables in the specified frame.
  """
  def variables([variables, _]), do: variables

  @doc """
  Gets the list of bound values in the specified frame.
  """
  def values([_, values]), do: values

  @doc """
  Adds a new variable binding to a frame.
  """
  def bind(variable, value, []), do: [[variable], [value]]

  def bind(variable, value, frame) do
    [[variable] ++ variables(frame), [value] ++ values(frame)]
  end

  @doc """
  Tries to find the value bound to specified variable in the supplied frame.
  """
  def find(var, frame) do
    vars = variables(frame)
    idx = Enum.find_index(vars, fn item -> item == var end)

    if idx != nil do
      {:ok, val} = Enum.fetch(values(frame), idx)
      val
    end
  end

  @doc """
  Tries to replace a variable value in the supplied frame.
  """
  def replace(var, val, [vars, vals]) do
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
