defmodule Tentabucket.Mixfile do
  use Mix.Project

  @description """
    Simple Bitbucket API client library for Elixir
  """

  def project do
    [app: :tentabucket,
     version: "0.0.1",
     elixir: "~> 1.2",
     name: "Tentabucket",
     description: @description,
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :exjsx]]
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
    [{ :httpoison, "~> 0.8" },
     { :exjsx, "~> 3.2" },
     { :earmark, "~> 1.2", only: :docs },
     { :ex_doc, "~> 0.11", only: :docs },
     { :inch_ex, only: :docs },
     { :excoveralls, "~> 0.4", only: :test },
     { :exvcr, "~> 0.7", only: :test },
     { :meck, "~> 0.8", only: :test } ]
  end

  defp package do
    [ files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Hugo Duksis"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/duksis/tentabucket" } ]
  end
end
