defmodule Pensieve.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PensieveWeb.Telemetry,
      Pensieve.Repo,
      {DNSCluster, query: Application.get_env(:pensieve, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Pensieve.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Pensieve.Finch},
      # Start a worker by calling: Pensieve.Worker.start_link(arg)
      # {Pensieve.Worker, arg},
      # Start to serve requests, typically the last entry
      PensieveWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pensieve.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PensieveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
