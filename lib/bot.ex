defmodule Exile.Bot do
  use GenServer
  alias Timex.Date,       as: D
  alias Timex.DateFormat, as: DF

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
    {:ok, sock} = Socket.TCP.connect(state.host, state.port, packet: :line)
    {:ok, %{state | sock: sock}, 0}
  end

  def parse_message(message, socket) when is_binary(message) do
    message 
      |> String.split 
      |> parse_message(socket)
  end

  def parse_message([who, "PRIVMSG", channel | message], _socket) do
    [":" <> head | tail] = message
    message = Enum.join([head | tail], " ")
    message = "#{parse_sender(who)}: #{message}"
    date = D.local |> DF.format!("%F", :strftime)
    File.write!("logs/#{channel}-#{date}", message <> "\n", [:append])
    message
  end

  def parse_message(["PING", server], socket) do pong = "PONG #{server}\r\n"
    socket |> Socket.Stream.send!(pong)
    pong
  end

  def parse_message(message, _socket) do
    message |> Enum.join(" ")
  end

  def parse_sender(who) do
    ":" <> who = who
    who |> String.split("!") |> hd 
  end

  def handle_info(_, state) do
    state |> do_join_channel |> do_listen
    { :noreply, state }
  end

  defp do_join_channel(%{sock: sock} = state) do
    sock |> Socket.Stream.send!("NICK #{state.nick}\r\n")
    sock |> Socket.Stream.send!("USER #{state.nick} #{state.host} #{state.nick} #{state.nick}\r\n")
    sock |> Socket.Stream.send!("JOIN #{state.chan}\r\n")
    state
  end

  defp do_listen(%{sock: sock} = state) do
    case state.sock |> Socket.Stream.recv! do
      data when is_binary(data)->
        case parse_message(data, sock) do
          message -> 
            message
        end
        do_listen(state)
      nil ->
        :ok
    end
  end

end
