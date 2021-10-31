defmodule YoyakuWeb.Router do
  use YoyakuWeb, :router

  import YoyakuWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {YoyakuWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  # Other scopes may use custom stacks.
  scope "/api" do
    pipe_through :api

    get "/graphql", Absinthe.Plug.GraphiQL, schema: YoyakuWeb.Api.Schema, interface: :playground
    post "/graphql", Absinthe.Plug, schema: YoyakuWeb.Api.Schema
    post "/users/log_in", YoyakuWeb.UserSessionController, :create
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: YoyakuWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", YoyakuWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    post "/users/register", UserRegistrationController, :create
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", YoyakuWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
  end
end
