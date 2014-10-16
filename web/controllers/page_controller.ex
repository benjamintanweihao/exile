defmodule Exile.PageController do
  use Phoenix.Controller
  alias Timex.Date,       as: D
  alias Timex.DateFormat, as: DF
  alias Exile.ChannelStore

  plug :action

  def index(conn, _params) do
    formatted_date = D.local |> DF.format!("%F", :strftime)
    render conn, "index", channel: "Console", channels: ChannelStore.get_channels, date: formatted_date
  end

  def show(conn, params) do
    channel  = params["channel"] |> String.replace(".", "#")
    date     = params["date"] 
    messages = case File.read("logs/#{channel}-#{date}") do
      {:ok, binary} -> binary |> String.split("\n")
      _ -> [] 
    end
    render conn, "index", date: date, channel: channel, channels: ChannelStore.get_channels, messages: messages
  end

  def not_found(conn, _params) do
    render conn, "not_found"
  end

  def error(conn, _params) do
    render conn, "error"
  end
end
