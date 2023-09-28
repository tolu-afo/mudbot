defmodule Mudbot do
  @moduledoc """
    A D&D Productivity Dungeon Master
  """
  use Application

  alias Mudbot.EventSupervisor

  def start(type, args) do
    case startup(type, args) do
      {:ok, _} ->
        IO.puts("Mudbot started successfully")
        {:ok, self()}

      {:error, reason} ->
        IO.puts("Mudbot failed to start: #{reason}")
        {:error, reason}
    end
  end

  defp startup(_type, _args) do
    # your application startup code here
    IO.puts "Mudbot is Running"
    EventSupervisor.start_link(:mudbot)
    {:ok, self()}
  end
end
