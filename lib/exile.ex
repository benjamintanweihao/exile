defmodule Exile do
  use Application

  @host "irc.freenode.net"
  @port 6667

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Exile.NickGenerator, []),
      worker(Exile.ChannelStore, []),
      supervisor(Exile.BotSupervisor, [])
    ]

    opts = [strategy: :one_for_one, name: Exile.Supervisor]
    Supervisor.start_link(children, opts)

    # List all the channels ...
    # For each of the channels, log it.
    list_channels(@host, @port)
  end

  def list_channels(host, port) do
    nick = Exile.NickGenerator.get_new_nick
    Exile.ChannelLister.start_link(%{host: host, port: port, nick: nick, sock: nil})
  end

end
