defmodule FasterElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :faster_elixir,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp deps do
    [{:benchee, "~> 1.0"}]
  end
end
