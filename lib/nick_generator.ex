defmodule Exile.NickGenerator do
  @moduledoc"""
  Simple Agent to compute a new nickname
  """

  def start_link do
    Agent.start_link(fn -> %{nick: "exile-bot-", count: 0} end, name: __MODULE__)
  end

  def get_new_nick do
    Agent.get_and_update(__MODULE__, fn state ->
      new_state = %{state | count: state.count + 1}
      { "#{state.nick}#{state.count}", new_state }
    end)
  end

end
