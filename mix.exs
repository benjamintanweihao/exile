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

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Exile, []},
     applications: [:phoenix, :cowboy, :logger]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do

    [
      {:phoenix, git: "https://github.com/phoenixframework/phoenix", branch: "master"},
      {:cowboy, "~> 1.0"},
      {:socket, "~> 0.2.8"}
    ]
  end
end
