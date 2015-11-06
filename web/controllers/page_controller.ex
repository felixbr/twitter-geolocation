defmodule TwitterGeolocation.PageController do
  use TwitterGeolocation.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def ping(conn, _params) do
    TwitterGeolocation.Endpoint.broadcast!("tweets:stream", "new_tweet", %{body: "ping"})
    json conn, %{ping: true}
  end
end
