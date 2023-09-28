defmodule Mudbot.EventSupervisor do
  use Supervisor

  def start_link(args) do
    IO.puts "Starting Supervisor"
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
    IO.puts "Listening to Events"
  end

  @impl true
  def init(_init_arg) do
    children = [EventConsumer]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
