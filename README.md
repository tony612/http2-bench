# Http2Bench

Benchmark for two Erlang HTTP/2 clients [Gun](https://github.com/ninenines/gun)
and [Chatterbox](https://github.com/joedevivo/chatterbox)

I use Cowboy as the HTTP/2 server and use [Benchee](https://github.com/PragTob/benchee)
to run the benchmark.

## Run

```
# Start the server
$ iex -S mix
iex(1)> Http2Bench.Server.start
```

```
$ mix run bench/pingpong.exs
```

## Result

pingpong:

```
# on my laptop
Operating System: macOS
CPU Information: Intel(R) Core(TM) i5-6267U CPU @ 2.90GHz
Number of Available Cores: 4
Available memory: 16 GB
Elixir 1.6.1
Erlang 20.2.2
Benchmark suite executing with the following configuration:
warmup: 2 s
time: 1 min
parallel: 1
inputs: none specified
Estimated total run time: 2.07 min

Benchmarking chatterbox...
Benchmarking gun...

Name                 ips        average  deviation         median         99th %
gun               6.00 K       0.167 ms    ±32.08%       0.152 ms        0.29 ms
chatterbox       0.149 K        6.72 ms    ±24.56%        7.03 ms        9.30 ms

Comparison:
gun               6.00 K
chatterbox       0.149 K - 40.29x slower
```
