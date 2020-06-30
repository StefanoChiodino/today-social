# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :today_social,
  ecto_repos: [TodaySocial.Repo]

# Configures the endpoint
config :today_social, TodaySocialWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EePsUD9BDqGCDo0BO7JSMVkx3MbO6l8eG39oWW4w7FWFeCi+hBm4jteekrm04VaO",
  render_errors: [view: TodaySocialWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TodaySocial.PubSub,
  live_view: [signing_salt: "oxL/RhDR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :today_social, :pow,
  user: TodaySocial.Users.User,
  repo: TodaySocial.Repo,
  web_module: TodaySocialWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
