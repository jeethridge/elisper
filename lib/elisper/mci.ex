defmodule Elisper.MCI do
  @moduledoc """
  Defines the top level meta-circular evaluator.
  """
  import Elisper.{EvalConds, EvalActions, ApplyActions, ApplyConds}
  @doc """
  eval: Let's start with a naive implementation based on SICP
  and go from there.
  """
  def eval(exp, env) do
    cond do
      self_evaluating?(exp) -> exp
      variable?(exp) -> nil
      quoted?(exp) -> nil
      assignment?(exp) -> nil
      definition?(exp) -> nil
      if?(exp) -> nil
      lambda?(exp) -> nil
      begin?(exp) -> nil
      cond?(exp) -> nil
      application?(exp) -> nil
      true -> raise "Dishing out the plastic, do the dance till you spastic!"
    end
  end

  @doc """
  apply: ditto
  """
  def apply(procedure, arguments) do
    cond do
      primitive_procedure?(procedure) -> nil
      compound_procedure?(procedure) -> nil
      true -> raise "Dream what you like, but you dare not sleep"
    end
  end

end
