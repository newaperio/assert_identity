defmodule AssertIdentity.MixProject do
  use Mix.Project

  @version "0.1.0"
  @repo_url "https://github.com/newaperio/assert_identity"

  def project do
    [
      app: :assert_identity,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      docs: docs(),
      elixir: "~> 1.9",
      homepage_url: @repo_url,
      package: package(),
      source_url: @repo_url,
      start_permanent: Mix.env() == :prod,
      version: @version
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21.3", only: :dev}
    ]
  end

  defp description do
    "ExUnit assertions for comparing data structures by identity."
  end

  defp docs do
    [main: "readme", extras: ["README.md"]]
  end

  defp package() do
    [
      maintainers: ["Logan Leger"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @repo_url,
        "Made by NewAperio" => "https://newaperio.com"
      }
    ]
  end
end
