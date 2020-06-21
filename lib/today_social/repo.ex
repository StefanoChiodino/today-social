defmodule TodaySocial.Repo do
  use Ecto.Repo,
    otp_app: :today_social,
    adapter: Ecto.Adapters.Postgres
end
