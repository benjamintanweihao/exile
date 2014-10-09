defmodule Exile.Mixfile do
  use Mix.Project

  def project do
    [app: :exile,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     escript: 
       [main_module: Exile.CLI],
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:socket, "~> 0.2.8"}
    ]
  end
end
