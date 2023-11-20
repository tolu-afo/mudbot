defmodule Mudbot.Characters do
  alias Nostrum.Api
  alias Mudbot.CharacterManager

  def parse_char(parseObj) do
    [command, sec_command, content] = String.split(msg.content, " ", parts: 3)
    # example content -> "!char create tolu"
    # example #2 -> "!char stats"

    case sec_command do
      "create" ->
        {:ok, char} = CharacterManager.create_character(content, msg.author.username)
        Api.create_message(msg.channel_id, "Character Created! Name: #{char.name} ID: #{char.id}")
      "stats" ->
        # TODO: Add Stat Tracking for Character
        {:ok, char} = CharacterManager.get_character(msg.author.username)
        Api.create_message(msg.channel_id, "No Character Stats to be shown at this moment!")
    end
  end
end
