defmodule TwitterGeolocation.TwitterStream do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    IO.puts "init streaming"
    start_streaming
    :ok
  end

  def start_streaming do
    stream = ExTwitter.stream_sample
             |> Stream.filter(&tweet_has_geo/1)
            #  |> Stream.map(fn(t) -> %{body: t})

    for payload <- stream do
      # IO.puts "broadcasting"

      TwitterGeolocation.Endpoint.broadcast!("tweets:stream", "new_tweet", %{body: payload})
    end
  end

  def tweet_has_geo(tweet) do
    tweet.geo != nil
  end
end
