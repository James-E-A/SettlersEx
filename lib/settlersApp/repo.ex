defmodule SettlersApp.Repo do
  use Ecto.Repo,
    otp_app: :settlersApp,
    adapter: Ecto.Adapters.SQLite3
end
