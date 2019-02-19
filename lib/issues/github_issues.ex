defmodule Issues.GithubIssues do

  @user_agent [{"User-Agent", "Elixir miklblitz@yandex.ru"}]
  @github_url (Application.get_env(:issuees, :github_url))

  def fetch(user, project) do
    issue_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issue_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse! body}
  end

  def handle_response({_, %{status_code: _, body: body}}) do
    {:error, Poison.Parser.parse! body}
  end
end