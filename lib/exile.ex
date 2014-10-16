defmodule Exile do
  use Application

  @host  "irc.freenode.net"
  @port  6667

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Exile.NickGenerator, []),
      supervisor(Exile.BotSupervisor, [])
    ]

    opts = [strategy: :one_for_one, name: Exile.Supervisor]

    {:ok, pid} = Supervisor.start_link(children, opts)

    Exile.BotSupervisor.run(@host, @port)

    {:ok, pid}
  end

end
