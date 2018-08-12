# iex --name server@127.0.0.1 -S mix
# iex --name client@127.0.0.1 -S mix run bench/rpc.exs
# Name           ips        average  deviation         median         99th %
# rpc         7.78 K      128.57 μs   ±100.80%         120 μs         261 μs

node = :"server@127.0.0.1"

Benchee.run(
  %{
    "rpc" => fn -> {:ok, _} = RpcTest.rpc(node) end
  },
  time: 30,
  formatters: [
    # Benchee.Formatters.HTML,
    Benchee.Formatters.Console
  ]
)
