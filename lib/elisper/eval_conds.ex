defmodule Elisper.EvalConds do
  @moduledoc """
  A nice home for conditionals called by eval.
  """
  def self_evaluating?(exp) when is_number(exp), do: true
  def self_evaluating?(exp) when is_binary(exp), do: true
  def self_evaluating?(_), do: false

  def variable?(exp) when is_atom(exp), do: true
  def variable?(_), do: false

  def quoted?([:quoted | _]), do: true
  def quoted?(_), do: false

  def assignment?([:set!, _var, _val]), do: true
  def assignment?(_), do: false
  def definition?([:define, _var, _val]), do: true
  def definition?(_), do: false
  def if?([:if, _predicate, _consequent, _alternative]), do: true
  def if?([:if, _predicate, _consequent]), do: true
  def if?(_), do: false
  def lambda?([:lambda, _params, _body]), do: true
  def lambda?(_), do: false
  def begin?(exp), do: false
  def cond?(exp), do: false
  def application?(exp), do: false
end
