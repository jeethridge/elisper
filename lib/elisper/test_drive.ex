defmodule Elisper.TestDrive do
  @moduledoc """
  Repl driver for test-driving.
  """
  def run() do
    Elisper.Driver.repl(Elisper.Environment.global(), &Elisper.evaluate(&1))
  end
end
