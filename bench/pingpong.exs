gpid = Http2Bench.start_gun()
# cpid = Http2Bench.start_chatterbox()
Benchee.run(
  %{
    "gun" => fn -> Http2Bench.gun(gpid) end,
    "gun_post" => fn -> Http2Bench.gun_post(gpid) end,
    "gun_grpc" => fn -> Http2Bench.gun_grpc(gpid) end
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
