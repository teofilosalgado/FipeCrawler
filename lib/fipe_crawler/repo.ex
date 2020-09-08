defmodule FipeCrawler.Repo do
  use Ecto.Repo,
    otp_app: :fipe_crawler,
    adapter: Ecto.Adapters.Postgres
end
