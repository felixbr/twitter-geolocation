defmodule TwitterGeolocation.PageController do
  use TwitterGeolocation.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
