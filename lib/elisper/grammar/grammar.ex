defmodule Elisper.Grammar do
  @moduledoc """
  Defines the valid grammar for Elisper.
  """
  @primatives [:+, :-, :*, :/, :%, := , :&, :|, :<, :>, :!]
  @special_forms [:quoted, :begin, :define, :if, :car, :cdr]

  @doc """
  Get the grammar primatives.
  """
  def primatives(), do: @primatives

  @doc """
  Determine if a procedure is a primative
  """
  def primative?([operator , _ ]) do
    operator in @primatives
  end

end
