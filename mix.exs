defmodule EtherchainOrg.Mixfile do
  use Mix.Project

  def project do
    [app: :etherchain_org,
     version: "0.0.7",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 2.0"},
      {:httpoison, "~> 0.10"},
      {:vex, ">= 0.0.0"},
      {:credo, ">= 0.0.0", only: [:test,:dev]},
      {:ex_doc, ">= 0.0.0", only: [:dev]}
    ]
  end

  defp description do
    """
    WIP
    Elixir API wrapper for etherchain.org. Provides access to ethereum blockchain data.
    """
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "mix.exs", "LICENSE*"],
     maintainers: ["ontofractal"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/cyberpunk-ventures/etherchain_org_ex"}]
   end

end

