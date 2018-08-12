defmodule RpcTest do
  def hello(body) do
    request = HelloRequest.decode(body)
    reply = HelloReply.new(message: "Hello, #{request.name}")
    {:ok, HelloReply.encode(reply)}
  end

  def rpc(node) do
    req = HelloRequest.new(name: "Gun")
    body = HelloRequest.encode(req)
    :rpc.call(node, RpcTest, :hello, [body])
  end
end
