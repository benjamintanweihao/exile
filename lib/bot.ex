defmodule Exile.Bot do
  use GenServer

  @timeout 10_000

  def run(host, port, chan, nick \\ "exile-bot") do
    GenServer.start_link(__MODULE__, %{host: host, port: port, chan: chan, nick: nick, sock: nil})
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
    {:ok, sock} = Socket.TCP.connect(state.host, state.port, packet: :line)
    {:ok, %{state | sock: sock}, 0}
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

  def handle_info(_, state) do
    state |> do_join_channel |> do_listen
    { :noreply, state, :infinity }
  end

  defp do_join_channel(state) do
    state.sock |> Socket.Stream.send!("NICK #{state.nick}\r\n")
    state.sock |> Socket.Stream.send!("USER #{state.nick} #{state.host} #{state.nick} #{state.nick}\r\n")
    state.sock |> Socket.Stream.send!("JOIN #{state.chan}\r\n")
    state
  end

  defp do_listen(state) do
    case state.sock |> Socket.Stream.recv! do
      data when is_binary(data)->
        case parse_message(data) do
          message -> IO.puts message
        end
        do_listen(state)
      nil ->
        :ok
    end
  end

end
