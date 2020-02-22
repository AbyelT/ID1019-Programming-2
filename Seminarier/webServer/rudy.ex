defmodule Rudy do

  def start(port) do
    Process.register(spawn(fn -> init(port) end), :one)
    Process.register(spawn(fn -> init(port) end), :two)
    Process.register(spawn(fn -> init(port) end), :three)
    Process.register(spawn(fn -> init(port) end), :four)
    Process.register(spawn(fn -> init(port) end), :five) 
  end

  def stop() do
    Process.exit(Process.whereis(:one), "Time to die!")
    Process.exit(Process.whereis(:two), "Time to die!")
    Process.exit(Process.whereis(:three), "Time to die!")
    Process.exit(Process.whereis(:four), "Time to die!")
    Process.exit(Process.whereis(:five), "Time to die!")
  end
    
  def init(port) do
    opt = [:list, active: false, reuseaddr: true]

    case :gen_tcp.listen(port, opt) do
      {:ok, listen} ->
        handler(listen)
        :gen_tcp.close(listen)
        :ok
      {:error, error} ->
        error
    end
  end

  def handler(listen) do
    case :gen_tcp.accept(listen) do
      {:ok, client} ->
        request(client)
        handler(listen)
      {:error, error} ->
        :timer.sleep(100)
        handler(listen)
    end
  end

  def request(client) do
    recv = :gen_tcp.recv(client, 0)
    case recv do
      {:ok, str} ->
        parsed = HTTP.parse_request(str)
        response = Rudy.reply(parsed)
        :gen_tcp.send(client, response)
      {:error, error} ->
        IO.puts("RUDY ERROR: #{error}")
    end
    :gen_tcp.close(client)
  end

  def reply({{:get, uri, _}, _, _}) do
    :timer.sleep(10)
    HTTP.ok("Hello!")
  end
end