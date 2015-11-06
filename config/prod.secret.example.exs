use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :twitter_geolocation, TwitterGeolocation.Endpoint,
  secret_key_base: ""

# Configure your database
config :twitter_geolocation, TwitterGeolocation.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "twitter_geolocation_prod",
  pool_size: 20
