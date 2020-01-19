defmodule TwitterGeolocation.TwitterStream.TweetsCollector do

  def start_link(opts \\ []) do
    Agent.start_link(fn -> HashSet.new end, name: :tweets_collector_subscribers)

    start_streaming
    {:ok, self}
  end

  def subscribe(pid) do
    Agent.update :tweets_collector_subscribers, fn subscribers ->
      Set.put subscribers, pid
    end
  end

  def unsubscribe(pid) do
    Agent.update :tweets_collector_subscribers, fn subscribers ->
      Set.remove subscribers, pid
    end
  end

  defp start_streaming do
    IO.puts "connecting to twitter stream"
    # if the stream crashes, crash this process
    spawn_link fn ->
      ExTwitter.stream_sample
      #|> Stream.map(&IO.inspect/1)
      |> Stream.filter(&tweet_has_coordinates/1)
      |> Stream.each(&broadcast_tweet/1)
      |> Stream.run

      # try again if connection fails
      start_streaming
    end
  end

  defp tweet_has_coordinates(tweet) do
    tweet.coordinates != nil
  end

  defp broadcast_tweet(tweet) do
    subscribers = Agent.get(:tweets_collector_subscribers, &(&1))

    Enum.each subscribers, fn subscriber -> send subscriber, tweet end
  end
end
