defmodule CliTest do
  use ExUnit.Case
  import Issues.CLI, only: [ parse_args: 1, sort_into_ascending_order: 1 ]

  test "sort ascending orders the correct way" do
    result = sort_into_ascending_order(fake_created_at_list(["c","a","b","w","f"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues== ~w[a b c f w]
  end

  defp fake_created_at_list(values) do
    for value <- values, do: %{"created_at" => value, "other_data"=>"xxx"}
  end
end