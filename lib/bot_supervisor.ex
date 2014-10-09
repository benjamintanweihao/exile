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
end
