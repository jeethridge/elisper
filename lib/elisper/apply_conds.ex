defmodule Elisper.ApplyConds do
  @moduledoc """
  A nice home for conditionals called by apply.
  """
  alias Elisper.Grammar
  def primitive_procedure?(procedure) do
    [operator | _] = procedure
    #TODO we could ditch the Grammar module and just check the global environment,
    #but we'd want the lookup_variable function to not throw when not found in that case.
    operator in Grammar.primatives()
  end

  @spec compound_procedure?(any()) :: false
  def compound_procedure?(procedure), do: false
end
