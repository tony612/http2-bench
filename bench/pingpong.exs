# Name               ips        average  deviation         median         99th %
# gun             4.64 K      215.65 μs   ±136.04%         197 μs         560 μs
# gun_post        3.30 K      302.97 μs   ±171.38%         248 μs     1106.85 μs
# gun_grpc        3.25 K      307.79 μs   ±282.00%         268 μs      711.99 μs
gpid = Http2Bench.start_gun()
# cpid = Http2Bench.start_chatterbox()
Benchee.run(
  %{
    "gun" => fn -> {:ok, _} = Http2Bench.gun(gpid) end,
    "gun_post" => fn -> {:ok, _, _} = Http2Bench.gun_post(gpid) end,
    "gun_grpc" => fn -> {:ok, _, _} = Http2Bench.gun_grpc(gpid) end
    # "chatterbox" => fn -> Http2Bench.chatterbox(cpid) end
  },
  time: 30,
  formatters: [
    # Benchee.Formatters.HTML,
    Benchee.Formatters.Console
  ]
)

# now = Time.utc_now(); Enum.each(0..10000, fn _ -> Http2Bench.gun(gpid) end); Time.diff(Time.utc_now(), now, :millisecond)
# now = Time.utc_now(); Enum.each(0..10000, fn _ -> Http2Bench.gun_grpc(gpid) end); Time.diff(Time.utc_now(), now, :millisecond)
# now = Time.utc_now(); Enum.each(0..10000, fn _ -> Http2Bench.gun_post(gpid) end); Time.diff(Time.utc_now(), now, :millisecond)
