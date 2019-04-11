# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :awesome_elixir_parser,
  ecto_repos: [AwesomeElixirParser.Repo]

# Configures the endpoint
config :awesome_elixir_parser, AwesomeElixirParserWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uzlwfHegZNAosZTOZEU+UPtQ0ulV1lYRpFLSD6ugRHCvw78fmL6hylN8Ei6p+n8z",
  render_errors: [view: AwesomeElixirParserWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AwesomeElixirParser.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
