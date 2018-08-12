defmodule Http2Bench do
  @port 50051

  def start_gun do
    {:ok, conn_pid} =
      :gun.open('127.0.0.1', @port, %{protocols: [:http2], transport_opts: [nodelay: true]})

    {:ok, :http2} = :gun.await_up(conn_pid)
    conn_pid
  end

  def gun(conn_pid) do
    stream_ref = :gun.get(conn_pid, "/hello")

    case :gun.await(conn_pid, stream_ref) do
      {:response, :fin, _status, _headers} ->
        :no_data

      {:response, :nofin, _status, _headers} ->
        {:ok, _body} = :gun.await_body(conn_pid, stream_ref)
    end
  end

  def gun_post(conn_pid) do
    headers = [
      {"te", "trailers"}
    ]

    stream_ref = :gun.post(conn_pid, "/post", headers, <<10, 0>>)

    case :gun.await(conn_pid, stream_ref) do
      {:response, :fin, _status, _headers} ->
        :no_data

      {:response, :nofin, _status, _headers} ->
        {:ok, _body, _trailers} = :gun.await_body(conn_pid, stream_ref)
    end
  end

  def gun_grpc(conn_pid) do
    path = "/grpc.testing.BenchmarkService/UnaryCall"

    headers = [
      {"content-type", "application/grpc+proto"},
      {"user-agent", "grpc-elixir/0.3.0-alpha.2"},
      {"te", "trailers"},
      {"grpc-timeout", "10S"}
    ]

    req = HelloRequest.new(name: "Gun")

    stream_ref = :gun.post(conn_pid, path, headers, HelloRequest.encode(req))

    case :gun.await(conn_pid, stream_ref) do
      {:response, :fin, _status, _headers} ->
        :no_data

      {:response, :nofin, _status, _headers} ->
        {:ok, _body, _tailers} = :gun.await_body(conn_pid, stream_ref)
    end
  end

  def start_chatterbox do
    {:ok, pid} = :h2_client.start_link(:http, '127.0.0.1', @port)
    pid
  end

  def chatterbox(pid) do
    req_headers = [
      {":method", "GET"},
      {":path", "/hello"},
      {":scheme", "http"},
      {":authority", "localhost:50051"},
      {"accept", "*/*"},
      {"user-agent", "chatterbox-client/0.0.1"}
    ]

    req_body = <<>>

    {:ok, {_resp_headers, _resp_body}} = :h2_client.sync_request(pid, req_headers, req_body)
    # IO.inspect(resp_headers)
    # IO.inspect(resp_body)
  end
end
