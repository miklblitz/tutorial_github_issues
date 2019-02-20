defmodule Issuees.MixProject do
  use Mix.Project

  def project do
    [
      name: "Github Issues",
      app: :issuees,
      escript: escript_config,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/miklblitz/tutorial_github_issues",
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:poison, "~>3.1"},
      {:ex_doc, "~> 0.19.0"},
      {:earmark, "~> 1.3.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp escript_config do
    [ main_module: Issues.CLI ]
  end

end
