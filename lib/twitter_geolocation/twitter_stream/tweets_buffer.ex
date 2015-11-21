defmodule TwitterGeolocation.TwitterStream.TweetsBuffer do

  alias TwitterGeolocation.TwitterStream.TweetsCollector

  def start_link(opts \\ []) do
    buffer_size = opts[:buffer_size] || 20
    name = opts[:name] || :tweets_buffer

    {:ok, buffer_pid} = Agent.start_link(fn -> {buffer_size, []} end, name: name)

    # subscribe to TweetsCollector
    receiver_pid = spawn_link fn ->
      receive_next_tweet buffer_pid
    end
    TweetsCollector.subscribe receiver_pid

    {:ok, buffer_pid}
  end

  def new_tweet(buffer, tweet) do
    Agent.update(buffer, fn {buffer_size, tweets} ->
      updated_tweets = [tweet | tweets]
      |> Enum.take buffer_size

      {buffer_size, updated_tweets}
    end)

    TwitterGeolocation.Endpoint.broadcast_tweet!(tweet)
  end

  def to_list(buffer) do
    Agent.get(buffer, fn {_, tweets} -> Enum.reverse tweets end)
  end

  defp receive_next_tweet(buffer_pid) do
    receive do
      tweet ->
        new_tweet buffer_pid, tweet

        receive_next_tweet buffer_pid
    end
  end
end
