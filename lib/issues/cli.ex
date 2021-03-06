# Examples:
# Issues.CLI.run("kugaevsky", "jquery-phoenix")
# Issues.CLI.run(["rails", "rails", "60"])
#
# или, с консоли:
# mix run -e 'Issues.CLI.run(["elixir-lang","elixir","5"])'
# 
defmodule Issues.CLI do
  
  import Issues.TableFormatter, only: [print_table_for_columns: 2]

  @default_count 4
  
  @moduledoc """
    Parse string
  """
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
    Parse a github repo
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _ }            -> :help
      {_, [user, project, count], _}   -> {user, project, String.to_integer(count)}
      {_, [user, project], _}          -> {user, project, @default_count}
      _                                -> :help
    end
  end

  @doc """
    Processing
  """
  def process(:help) do
    IO.puts """
      usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> print_table_for_columns(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort list_of_issues, &(Map.get(&1, "created_at")>=Map.get(&2, "created_at"))
  end

end