defmodule Exile.Bot do
  use GenServer

  @nick    "exile-bot"
  @timeout 10_000

  def start_link(host, port, chan, nick \\ @nick) do
    GenServer.start_link(__MODULE__, %{host: host, port: port, chan: chan, nick: nick, sock: nil}, timeout: @timeout)
  end

  def join_channel(pid) do
    GenServer.call(pid, :join_channel)
  end

  def listen(pid) do
    GenServer.cast(pid, :listen)
  end

  def parse_message(message) when is_binary(message) do
    message 
      |> String.split 
      |> parse_message
  end

  def parse_message([who, "PRIVMSG", _channel | message]) do
    [":" <> head | tail] = message
    message = Enum.join([head | tail], " ")
    "#{parse_sender(who)}: #{message}"
  end

  def parse_message(message) do
    message |> Enum.join(" ")
  end

  def parse_sender(who) do
    ":" <> who = who
    who |> String.split("!") |> hd 
  end

  def handle_call(:join_channel, _from, state) do
    {:ok, sock} = Socket.TCP.connect(state.host, state.port, packet: :line)
    sock |> Socket.Stream.send!("NICK #{state.nick}\r\n")
    sock |> Socket.Stream.send!("USER #{state.nick} #{state.host} #{state.nick} #{state.nick}\r\n")
    sock |> Socket.Stream.send!("JOIN #{state.chan}\r\n")

    state = %{state | sock: sock}
    {:reply, state, state}
  end

  def handle_cast(:listen, state) do
    {:noreply, state, 0}
  end

  def handle_info(:timeout, state) do
    do_listen(state)
    { :noreply, state }
  end

  defp do_listen(state) do
    case state.sock |> Socket.Stream.recv! do
      data when is_binary(data)->
        case parse_message(data) do
          message -> IO.puts message
          nil -> :ok
        end
      nil ->
        :ok
    end
    do_listen(state)
  end

end
