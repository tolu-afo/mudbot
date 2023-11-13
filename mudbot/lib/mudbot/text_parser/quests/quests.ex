defmodule Mudbot.Quests do
  def parse_quest(msg) do
    # Creating a Task
    # FORMAT: [command] [secondary_command] [content]

    alias Mudbot.QuestManager
    alias Mudbot.CharacterManager
    alias Nostrum.Api

    [command, sec_command, content] = String.split(msg.content)
    {:ok, character} = CharacterManager.get_character(msg.author.username)

    case sec_command do
      "create" ->
        # create task
        QuestManager.new_quest(content, character.id)

      # displays all uncompleted tasks from a user
      # TODO: third command for completed or uncompleted
      "display" ->
        case character.get_quests(character.id) do
          {:ok, quests} ->
            # construct quests
            Api.create_message(msg.channel_id, "#{quests}")
            # {:ok, quest_resp}
          {:error, err} ->
            "You don't have a character yet!"
        end
    end
  end
end
