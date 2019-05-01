defmodule Elisper.ApplyCondsTest do
  use ExUnit.Case
  import Elisper.ApplyConds

 test "A procedure with a primitive operator is primative" do
    procedure = [:+, 1, 1, 1]
    assert primitive_procedure?(procedure)
  end

  test "A procedure that does not have a primitive operator is not primitive" do
    procedure = [:define, :x, 2]
    assert not primitive_procedure?(procedure)
  end
end
