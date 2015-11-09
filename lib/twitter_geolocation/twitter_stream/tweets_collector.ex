defmodule TwitterGeolocation.TwitterStream.TweetsCollector do
  use GenServer

  def start_link(opts \\ []) do
    # used so this process doesn't exit immediately
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    IO.puts "init streaming"
    start_streaming
    {:ok, HashDict.new}
  end

  defp start_streaming do
    # if the stream crashes, crash this process
    spawn_link fn ->
      ExTwitter.stream_sample
      |> Stream.filter(&tweet_has_geo/1)
      |> Stream.each(&broadcast_tweet/1)
      |> Stream.run

      # try again if connection fails
      start_streaming
    end
  end

  defp tweet_has_geo(tweet) do
    tweet.geo != nil
  end

  defp broadcast_tweet(tweet) do
    TwitterGeolocation.Endpoint.broadcast!("tweets:stream", "new_tweet", %{body: tweet})
  end
end
