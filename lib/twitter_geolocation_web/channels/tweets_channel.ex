defmodule TwitterGeolocationWeb.TweetsChannel do
  use Phoenix.Channel

  alias TwitterGeolocation.TwitterStream.TweetsBuffer

  def join("tweets:stream", payload, socket) do
    {:ok, socket}
  end

  def handle_in("retrieve_buffered_tweets", _payload, socket) do
    tweets = TweetsBuffer.to_list :tweets_buffer
    {:reply, {:ok, %{body: tweets}}, socket}
  end
  def handle_in(event, payload, socket) do
    IO.inspect payload
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, tweet = %ExTwitter.Model.Tweet{}, socket) do
    IO.puts "publishing tweet"
    # needed because I couldn't figure out how to derive the Jason protocol and newer ExTwitter versions solve that but crash during streaming
    payload = %{
      text: tweet.body.text,
      coordinates: tweet.geo.coordinates
    }

    push socket, event, payload
    {:noreply, socket}
  end
  def handle_out(event, payload, socket) do
    IO.puts "publishing out"
    push socket, event, payload
    {:noreply, socket}
  end
end