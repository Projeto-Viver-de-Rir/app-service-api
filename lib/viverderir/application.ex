defmodule Viverderir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ViverderirWeb.Telemetry,
      Viverderir.Repo,
      {DNSCluster, query: Application.get_env(:viverderir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Viverderir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Viverderir.Finch},
      # Start a worker by calling: Viverderir.Worker.start_link(arg)
      # {Viverderir.Worker, arg},
      # Start to serve requests, typically the last entry
      ViverderirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Viverderir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ViverderirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
