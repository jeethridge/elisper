defmodule Elisper.EvalConds do
  @moduledoc """
  A nice home for conditionals called by eval.
  """
  def self_evaluating?(exp), do: false
  def variable?(exp), do: false
  def quoted?(exp), do: false
  def assignment?(exp), do: false
  def definition?(exp), do: false
  def if?(exp), do: false
  def lambda?(exp), do: false
  def begin?(exp), do: false
  def cond?(exp), do: false
  def application?(exp), do: false
end