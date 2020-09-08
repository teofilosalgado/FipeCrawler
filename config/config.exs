import Config

config :tesla, adapter: Tesla.Adapter.Hackney

config :fipe_crawler, FipeCrawler.Repo,
  database: "fipe_crawler",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  loggers: []

config :fipe_crawler, ecto_repos: [FipeCrawler.Repo]

config :money,
  default_currency: :BRL,
  separator: ".",
  delimiter: ","
