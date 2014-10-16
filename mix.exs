defmodule Exile.Mixfile do
  use Mix.Project

  def project do
    [app: :exile,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  def application do
    [mod: {Exile, []},
     applications: [:phoenix, :cowboy, :logger]]
  end

  defp deps do
    [
      {:phoenix, git: "https://github.com/phoenixframework/phoenix", branch: "master"},
      {:cowboy, "~> 1.0"},
      {:timex, "~> 0.12.9"},
      {:socket, "~> 0.2.8"}
    ]
  end
end
