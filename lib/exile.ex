defmodule Exile do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Exile.NickGenerator, []),
      supervisor(Exile.BotSupervisor, [])
    ]

    opts = [strategy: :one_for_one, name: Exile.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def log(host, port, chan) do
    nick = Exile.NickGenerator.get_new_nick
    Supervisor.start_child(Exile.BotSupervisor, [%{host: host, port: port, chan: chan, nick: nick, sock: nil}])
  end

end
