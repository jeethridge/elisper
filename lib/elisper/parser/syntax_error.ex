defmodule Elisper.Parser.SyntaxError do
  defexception message: "Bad syntax!"

  def full_message(error) do
    "Elisper Syntax Error: #{error.message}"
  end

end
