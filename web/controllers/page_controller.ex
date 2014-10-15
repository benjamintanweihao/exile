defmodule Exile.PageController do
  use Phoenix.Controller
  alias Timex.Date,       as: D
  alias Timex.DateFormat, as: DF

  plug :action

  def index(conn, _params) do
    formatted_date = D.local |> DF.format!("%F", :strftime)
    render conn, "index", channels: ["#elixir-lang"], date: formatted_date
  end

  def show(conn, params) do
    channel = params["channel"]
    date    = params["date"] 
    render conn, "index", date: date, channel: channel, date: date
  end

  def not_found(conn, _params) do
    render conn, "not_found"
  end

  def error(conn, _params) do
    render conn, "error"
  end
end
