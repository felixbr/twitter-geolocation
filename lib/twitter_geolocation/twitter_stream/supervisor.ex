defmodule TwitterGeolocation.TwitterStream.Supervisor do
  use Supervisor

  alias TwitterGeolocation.TwitterStream.TweetsBuffer
  alias TwitterGeolocation.TwitterStream.TweetsCollector

  def start_link(args) do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @buffer_name :tweets_buffer
  @collector_name :tweets_collector

  def init(:ok) do
    children = [
      worker(TweetsCollector, [[name: @collector_name]]),
      worker(TweetsBuffer, [[name: @buffer_name, buffer_size: 20]]),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
