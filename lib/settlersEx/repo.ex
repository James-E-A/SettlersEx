defmodule SettlersEx.Repo do
  use Ecto.Repo,
    otp_app: :settlersEx,
    adapter: Ecto.Adapters.SQLite3
end
