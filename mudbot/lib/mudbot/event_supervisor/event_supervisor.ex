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

defmodule EventConsumer do
  use Nostrum.Consumer

  alias Mudbot.TextParser

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    {:ok, parseObj} = TextParser.construct_parse(msg)

    TextParser.parse_msg(parseObj)
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
