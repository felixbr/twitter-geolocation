use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :twitter_geolocation, TwitterGeolocation.Endpoint,
  secret_key_base: ""

config :extwitter, :oauth, [
  consumer_key: "",
  consumer_secret: "",
  access_token: "",
  access_token_secret: ""
]

config :twitter_geolocation, :mapbox, [
  id: "",
  access_token: ""
]
