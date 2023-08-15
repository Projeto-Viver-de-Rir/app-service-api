defmodule ViverderirWeb.Router do
  use ViverderirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ViverderirWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ViverderirWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api/v1", ViverderirWeb do
    pipe_through :api

    scope "/accounts" do
      get "/", AccountsController, :get_me
      post "/sign-in", AccountsController, :sign_in
      post "/sign-up", AccountsController, :sign_up
      post "/sign-out", AccountsController, :sign_out
      delete "/delete", AccountsController, :delete
    end

    scope "/events" do
      get "/", EventsController, :index
      get "/:id", EventsController, :detail
      post "/", EventsController, :create
      put "/:id", EventsController, :update
      patch "/:id", EventsController, :patch
      delete "/:id", EventsController, :delete
    end

    scope "/volunteers" do
      get "/", VolunteersController, :index
      get "/:id", VolunteersController, :detail
      post "/", VolunteersController, :create
      put "/:id", VolunteersController, :update
      patch "/:id", VolunteersController, :patch
      delete "/:id", VolunteersController, :delete
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:viverderir_web, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ViverderirWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
