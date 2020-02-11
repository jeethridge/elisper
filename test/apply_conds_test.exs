defmodule Elisper.ApplyCondsTest do
  use ExUnit.Case
  import Elisper.ApplyConds

  test "A primitive procedure is an elixir function" do
    procedure = fn x -> x + 1 end
    assert primitive_procedure?(procedure)
  end
end
