defmodule Mudbot.TextParser do

  alias Nostrum.Api
  alias Mudbot.Quests
  # alias Mudbot.CharacterManager

  def parse_msg(msg) do
    # Taking in text commands from discord users and parsing them,
    # username = msg.author.username
    # get associated character

    case msg.content do
      # ping bot
      "!ping" ->
        Api.create_message(msg.channel_id, "pong!")

      # TODO: productivity tasks
      "!task" ->
        Quests.parse_quest(msg)

      # # creates new character
      # "!char"->
      #   char = CharacterManager.create_character(username)
      #   Api.create_message(msg.channel_id, "Character Created! ID: #{char.id}")

      # TODO: campaigns
      _ -> :ignore
    end
  end
end
