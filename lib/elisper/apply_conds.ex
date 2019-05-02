defmodule Elisper.ApplyConds do
  @moduledoc """
  A nice home for conditionals called by apply.
  """
  def primitive_procedure?(procedure) do
    is_function(procedure)
  end

  @spec compound_procedure?(any()) :: false
  def compound_procedure?(procedure), do: false
end
