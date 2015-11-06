defmodule TwitterGeolocation.LayoutView do
  use TwitterGeolocation.Web, :view

  def get_mapbox_id do
    Application.get_all_env(:twitter_geolocation)[:mapbox][:id]
  end

  def get_mapbox_access_token do
    Application.get_all_env(:twitter_geolocation)[:mapbox][:access_token]
  end
end
