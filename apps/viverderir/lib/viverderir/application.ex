defmodule Viverderir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: Viverderir.PubSub},
      # Start Finch
      {Finch, name: Viverderir.Finch}
      # Start a worker by calling: Viverderir.Worker.start_link(arg)
      # {Viverderir.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Viverderir.Supervisor)
  end
end
