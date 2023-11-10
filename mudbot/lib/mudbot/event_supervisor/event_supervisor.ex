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

  alias Nostrum.Api
  alias Mudbot.CharacterManager

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    case msg.content do
      "!char" ->
        char = CharacterManager.create_character(msg.author.username)
        IO.inspect(char)
        Api.create_message(msg.channel_id, "character created! ID: #{char.id}")
      "!sleep" ->      
        Api.create_message(msg.channel_id, "Going to sleep...")
        Process.sleep(3000)
        Api.create_message(msg.channel_id, "I'm awake!")

      "!ping" -> Api.create_message(msg.channel_id, "pong!")

      "!raise" ->
        # This won't crash the entire Consumer.
        raise "No problems here!"

      _ -> :ignore
    end
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
