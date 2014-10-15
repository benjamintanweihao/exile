defmodule Exile.PageController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index", channels: ["#elixir-lang"]
  end

  def not_found(conn, _params) do
    render conn, "not_found"
  end

  def error(conn, _params) do
    render conn, "error"
  end
end
