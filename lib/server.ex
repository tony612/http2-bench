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
      path = :cowboy_req.path(req)

      case path do
        "/hello" ->
          req = :cowboy_req.reply(200, %{"content-type" => "text/plain"}, "Hello, world!", req)
          {:ok, req, s}

        _ ->
          {:ok, body, req} = read_full_body(req)
          req = :cowboy_req.stream_reply(200, req)
          :cowboy_req.stream_body(body, :nofin, req)

          trailers = %{
            "grpc-status" => "0",
            "grpc-message" => ""
          }

          :cowboy_req.stream_trailers(trailers, req)

          {:ok, req, s}
      end
    end

    defp read_full_body(req, body \\ "") do
      case :cowboy_req.read_body(req) do
        {:ok, data, req} -> {:ok, body <> data, req}
        {:more, data, req} -> read_full_body(req, body <> data)
      end
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
