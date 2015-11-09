defmodule TwitterGeolocation.TwitterStream.CollectorSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @collector_name TwitterGeolocation.TwitterStream.TweetsCollector

  def init(:ok) do
    children = [
      worker(TwitterGeolocation.TwitterStream.TweetsCollector, [[name: @collector_name]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
