# defmodule Mudbot.EventSupervisor do
#   use Supervisor

#   def start_link(args) do
#     Supervisor.start_link(__MODULE__, args, name: __MODULE__)
#   end

#   @impl true
#   def init(_init_arg) do
#     children = [ExampleConsumer]

#     Supervisor.init(children, strategy: :one_for_one)
#   end
# end

# defmodule ExampleConsumer do
#   use Nostrum.Consumer

#   alias Nostrum.Api

#   def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
#     case msg.content do
#       "!sleep" ->
#         Api.create_message(msg.channel_id, "Going to sleep...")
#         # This won't stop other events from being handled.
#         Process.sleep(3000)

#       "!ping" ->
#         Api.create_message(msg.channel_id, "pyongyang!")

#       "!raise" ->
#         # This won't crash the entire Consumer.
#         raise "No problems here!"

#       _ ->
#         :ignore
#     end
#   end

#   # Default event handler, if you don't include this, your consumer WILL crash if
#   # you don't have a method definition for each event type.
#   def handle_event(_event) do
#     :noop
#   end
# end

defmodule Mudbot.EventSupervisor do
  use Supervisor

  def start_link(args) do
    IO.puts "Starting Supervisor"
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
    IO.puts "Listening to Events"
  end

  @impl true
  def init(_init_arg) do
    IO.puts "I get called"
    children = [EventConsumer]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

defmodule EventConsumer do
  use Nostrum.Consumer

  alias Nostrum.Api

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    IO.puts(msg.content)
    case msg.content do
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
