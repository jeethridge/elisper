defmodule Elisper.Grammar do
  @moduledoc """
  Defines the valid grammar for Elisper.
  """
  @op_chars ["+", "-", "*", "/", "%", "=", "&", "|", "<", ">", "!", "'"]
  @special_forms ["begin", "define", "if"]

  def strings() do
    grammar_list = @op_chars ++ @special_forms
  end

end
