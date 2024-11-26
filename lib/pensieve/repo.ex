defmodule Pensieve.Repo do
  use Ecto.Repo,
    otp_app: :pensieve,
    adapter: Ecto.Adapters.Postgres
end
