defmodule Mudbot.QuestManager do
  @moduledoc """
  This is the quest manager (glorified todo manager) that will perform CRUD operations on the tasks of players.
  """

  defstruct name: "", challenge_score: 0, completed: false

  # Function to create a new quest item
  def new_quest(name, challenge_score) when is_binary(name) do
    %__MODULE__{name: name, completed: false, challenge_score: challenge_score}
  end

  # Function to mark a quest item as completed
  def complete_quest(quest) when is_map(quest) do
    %{quest | completed: true}
  end

  # Function to list all quests
  def list_quests(quests) when is_list(quests) do
    quests
  end

  # Function to filter completed quests
  def filter_completed(quests) when is_list(quests) do
    Enum.filter(quests, &(&1.completed))
  end

  # Function to filter incomplete quests
  def filter_incomplete(quests) when is_list(quests) do
    Enum.filter(quests, fn quest -> not quest.completed end)
  end

  # Function to delete a quest by index
  def delete_quest_by_index(quests, index) when is_list(quests) and is_integer(index) do
    Enum.delete_at(quests, index)
  end

end
