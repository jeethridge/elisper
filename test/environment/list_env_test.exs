defmodule ListEnvTest do
  use ExUnit.Case

  alias Elisper.Environment.ListEnv

  test "empty environment is empty list" do
    assert ListEnv.empty == []
  end
end
