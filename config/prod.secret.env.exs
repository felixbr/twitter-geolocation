use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :twitter_geolocation, TwitterGeolocation.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :extwitter, :oauth, [
   consumer_key: System.get_env("CONSUMER_KEY"),
   consumer_secret: System.get_env("CONSUMER_SECRET"),
   access_token: System.get_env("ACCESS_TOKEN"),
   access_token_secret: System.get_env("ACCESS_TOKEN_SECRET")
]

config :twitter_geolocation, :mapbox, [
  id: System.get_env("MAPBOX_ID"),
  access_token: System.get_env("MAPBOX_ACCESS_TOKEN")
]
