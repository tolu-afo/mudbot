defmodule Mudbot.TextParser do

  alias Nostrum.Api
  alias Mudbot.Quests
  alias Mudbot.Characters

  # username, command, sec_command, command, channel_id
  defstruct username: "", channel_id: nil, args: []

  def construct_parse(msg) do

    # is consume a string of varying length and be able to return 1, 2, or 3 elements

    # !ping
    # !task list
    # !char create name

    content = String.split(msg.content, " ", parts: 3)

    parseObj = %__MODULE__{
      username: msg.author.username,
      channel_id: msg.channel_id,
      command: hd(content),
      args: tl(content)
    }

    {:ok, parseObj}
  end

  def parse_msg(parseObj) do # will take msg_struct
    # Taking in text commands from discord users and parsing them,
    {channel_id, command} = parseObj

    case command do
      # ping bot
      "!ping" ->
        Api.create_message(channel_id, "pong!")

      # TODO: productivity (quests) tasks
      "!task" ->
        Quests.parse_quest(parseObj)

      # # creates new character
      "!char" ->
        Characters.parse_char(parseObj)

      # TODO: campaigns
      _ -> :ignore
    end
  end
end
