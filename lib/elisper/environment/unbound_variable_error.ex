defmodule Elisper.Environment.UnboundVariableError do
  defexception message: "Unbound variabe!"

  def full_message(error) do
    "Elisper Error: #{error.message}"
  end
end
