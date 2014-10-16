defmodule Exile.ChannelLister do
  use GenServer

  alias Exile.ChannelStore
  alias Exile.BotSupervisor
  @sleep 1000

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, sock} = Socket.TCP.connect(state.host, state.port, packet: :line)
    {:ok, %{state | sock: sock}, 0}
  end

  def parse_message(message) when is_binary(message) do
    message 
      |> String.split 
      |> Enum.drop(3) 
      |> Enum.filter(&(String.starts_with?(&1, "#"))) 
      |> List.first
  end

  def parse_message(_message), do: :nil

  def handle_info(_, state) do
    state |> do_list_channels |> do_listen
    { :noreply, state }
  end

  defp do_list_channels(%{sock: sock} = state) do
    sock |> Socket.Stream.send!("NICK #{state.nick}\r\n")
    sock |> Socket.Stream.send!("USER #{state.nick} #{state.host} #{state.nick} #{state.nick}\r\n")
    sock |> Socket.Stream.send!("LIST\r\n")
    state
  end

  defp do_listen(%{host: host, port: port, sock: sock} = state) do
    case sock |> Socket.Stream.recv! |> parse_message do
      channel when is_binary(channel)-> 
        IO.puts channel
        channel |> ChannelStore.add_channel
        BotSupervisor.start_logging(host, port, channel)
        :timer.sleep @sleep
      _ -> :ok
    end
    do_listen(state)
  end

end
