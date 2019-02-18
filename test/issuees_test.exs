defmodule IssueesTest do
  use ExUnit.Case
  doctest Issuees

  test "greets the world" do
    assert Issuees.hello() == :world
  end
end
