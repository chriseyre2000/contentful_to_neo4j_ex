defmodule ContentfulToNeo4jEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :contentful_to_neo4j_ex,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end


  defp aliases do
    [
      iex: &iex/1
    ]
  end

  defp iex(_) do
    Mix.shell.cmd("iex -S mix")
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [applications: [
      :logger,
      :httpoison,
      :poison,
      :bolt_sips      
      ],
      extra_applications: [:logger], mod: 
      {Bolt.Sips.Application, [url: 'localhost', pool_size: 15, basic_auth: [username: "neo4j", password: "magicbeans"] ]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:poison, "~> 4.0"},
      {:bolt_sips, "~> 0.4.12"}
    ]
  end
end
