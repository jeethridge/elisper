defmodule Elisper.Environment.ListFrame do
  @moduledoc """
  Defines operations on list-based frames.
  """

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
