defmodule Http2Bench.MixProject do
  use Mix.Project

  def project do
    [
      app: :http2_bench,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: true,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gun, github: "ninenines/gun"},
      {:chatterbox, github: "joedevivo/chatterbox"},
      {:cowboy, "~> 2.2"},
      {:ranch, "~> 1.4.0", override: true},
      {:cowlib, "~> 2.1.0", override: true},
      {:benchee, "~> 0.11", only: :dev},
      {:benchee_html, "~> 0.4", only: :dev}
    ]
  end
end
