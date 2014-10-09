defmodule Exile.CLI do
  @moduledoc """
  Command line parser for logging IRC channels for a given server and channel
  """
  alias Exile.Bot

  def main(argv) do
    parse_args(argv)
    |> process
  end

  def parse_args(argv) do
    case OptionParser.parse(argv, aliases: [h: :host, p: :port, n: :nick, c: :chan], switches: [port: :integer]) do
      { [help: true], [], [] } ->
        :help
      { args, [], [] } ->
        args |> Enum.into %{}
    end
  end

  def process(%{host: _host, port: _port, chan: _chan, nick: _nick} = state) do
    {:ok, _pid} = Bot.start_link(state)
  end

  def process(:help) do
    IO.puts """
    usage: exile -h <host> -p <port> -c <channel> -n <nick>
    """
    System.halt(0)
  end

end

