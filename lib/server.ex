defmodule Http2Bench.Server do
  @port 50051

  defmodule Sup do
    def start_link() do
      Supervisor.start_link(__MODULE__, [], name: __MODULE__)
    end

    def init([]) do
      {:ok, {{:one_for_one, 10, 10}, []}}
    end
  end

  defmodule Handler do
    def init(req, s) do
      req = :cowboy_req.reply(200, %{"content-type" => "text/plain"}, "Hello, world!", req)
      {:ok, req, s}
    end
  end

  def start do
    dispatch =
      :cowboy_router.compile([
        {:_, [{:_, Handler, []}]}
      ])

    :cowboy.start_clear(:http2_bench, [port: @port], %{env: %{dispatch: dispatch}})
    Sup.start_link()
  end
end
