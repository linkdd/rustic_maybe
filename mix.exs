defmodule Rustic.Maybe.MixProject do
  use Mix.Project

  def project do
    [
      app: :rustic_maybe,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),

      name: "Rustic.Maybe",
      description: "Maybe monad for Elixir inspired by Rust Option type.",
      package: package(),
      source_url: "https://github.com/linkdd/rustic_maybe"
    ]
  end

  defp package do
    [
      name: "rustic_maybe",
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/linkdd/rustic_maybe"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md": [
          filename: "readme",
          title: "Overview"
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {
        # Documentation
        :ex_doc, "~> 0.25",
        only: :dev,
        runtime: false
      },
      {
        # Static Analysis
        :credo, "~> 1.4",
        only: [:dev, :test],
        runtime: false
      }
    ]
  end
end
