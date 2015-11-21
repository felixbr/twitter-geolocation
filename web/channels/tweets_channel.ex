defmodule TwitterGeolocation.TweetsChannel do
  use TwitterGeolocation.Web, :channel

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
  def handle_out(event, payload, socket) do
    IO.puts "publishing out"
    push socket, event, payload
    {:noreply, socket}
  end
end
