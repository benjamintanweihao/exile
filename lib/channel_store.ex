defmodule Exile.ChannelStore do
  @moduledoc"""
  Simple Agent to store channels
  """

  def start_link do
    Agent.start_link(fn -> HashSet.new end, name: __MODULE__)
  end

  def add_channel(channel) do
    Agent.update(__MODULE__, fn set ->
      HashSet.put(set, channel) 
    end)
  end

  def get_channels do
    Agent.get(__MODULE__, fn set ->
      set |> HashSet.to_list |> Enum.sort
    end)
  end

end
