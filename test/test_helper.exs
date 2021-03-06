ExUnit.start()

case :gen_tcp.connect('localhost', 6379, []) do
  {:ok, socket} ->
    :gen_tcp.close(socket)
  {:error, reason} ->
    msg = "Cannot connect to Redis (http://localhost:6379): #{:inet.format_error(reason)}"
    IO.puts :stderr, IO.ANSI.format([:red, msg])
    System.halt(1)
end

defmodule Redix.TestHelpers do
  def silence_log(fun) do
    Logger.remove_backend :console
    fun.()
    Logger.add_backend :console, flush: true
  end
end
