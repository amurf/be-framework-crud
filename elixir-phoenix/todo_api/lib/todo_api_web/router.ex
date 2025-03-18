defmodule TodoApiWeb.Router do
  use TodoApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodoApiWeb do
    pipe_through :api

    resources "/todos", TodoController, except: [:new, :edit]
  end

  # Catch-all route for handling 404s
  match :*, "/*path", TodoApiWeb.FallbackController, :not_found
end
