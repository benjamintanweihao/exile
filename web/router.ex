defmodule Exile.Router do
  use Phoenix.Router

  scope "/" do
    # Use the default browser stack.
    pipe_through :browser

    get "/",               Exile.PageController, :index, as: :pages
    get "/:channel/:date", Exile.PageController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end
end
