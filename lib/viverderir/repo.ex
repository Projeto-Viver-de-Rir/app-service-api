defmodule Viverderir.Repo do
  use Ecto.Repo,
    otp_app: :viverderir,
    adapter: Ecto.Adapters.Postgres
end
