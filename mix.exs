defmodule Codecamp2017.Mixfile do
  use Mix.Project

  def project do
    [
      app: :codecamp2017,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug],
      mod: {Codecamp2017, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:sweet_xml, "~> 0.6.5"},
      {:libgraph, "~> 0.11.0"},
      {:plug, "~> 1.4.3"},
      {:cowboy, "~> 1.1.2"},
      {:poison, "~> 3.1.0"}
    ]
  end
end
