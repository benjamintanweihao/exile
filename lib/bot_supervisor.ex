defmodule Exile.BotSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      worker(Exile.Bot, []),
    ]

    opts = [strategy: :simple_one_for_one]

    supervise(children, opts)
  end

  def run(host, port) do
    channels = Application.get_env(:exile, :channels) 
    channels |> Enum.map(fn chan ->
      nick = Exile.NickGenerator.get_new_nick
      Supervisor.start_child(__MODULE__, [%{host: host, port: port, chan: chan, nick: nick, sock: nil}])
    end)  
  end

end
