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
      # {:chatterbox, github: "joedevivo/chatterbox"},
      {:cowboy, github: "ninenines/cowboy"},
      {:gun, github: "ninenines/gun"},
      {:cowlib, github: "ninenines/cowlib", override: true},
      {:protobuf, github: "tony612/protobuf-elixir"},
      {:benchee, "~> 0.11", only: :dev},
      {:benchee_html, "~> 0.4", only: :dev}
    ]
  end
end
