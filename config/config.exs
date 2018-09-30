# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :recipes,
  ecto_repos: [Recipes.Repo]

# Configures the endpoint
config :recipes, RecipesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GYmML4W7MjPJAK+X8srfE+9rOXZCvN0p8nwvw+EsZanVrlf8Z0wgTEupUfHDDniA",
  render_errors: [view: RecipesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Recipes.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
