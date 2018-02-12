gpid = Http2Bench.start_gun
cpid = Http2Bench.start_chatterbox
Benchee.run(%{
  "gun"    => fn -> Http2Bench.gun(gpid) end,
  "chatterbox" => fn -> Http2Bench.chatterbox(cpid) end
}, time: 60, formatters: [
  Benchee.Formatters.HTML,
  Benchee.Formatters.Console
])
