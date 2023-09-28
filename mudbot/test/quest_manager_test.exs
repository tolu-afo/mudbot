defmodule QuestManagerTest do
  use ExUnit.Case
  alias Mudbot.QuestManager

  test "create a new quest" do
    quest = QuestManager.new_quest("Defeat the dragon", 100)
    assert quest.name == "Defeat the dragon"
    assert quest.challenge_score == 100
    refute quest.completed
  end

  test "mark a quest as completed" do
    quest = %{name: "Collect herbs", challenge_score: 50, completed: false}
    completed_quest = QuestManager.complete_quest(quest)
    assert completed_quest.completed
  end

  test "list all quests" do
    quests = [
      %{name: "Collect herbs", challenge_score: 50, completed: false},
      %{name: "Defeat the dragon", challenge_score: 100, completed: true},
      %{name: "Deliver a message", challenge_score: 75, completed: false}
    ]

    listed_quests = QuestManager.list_quests(quests)

    assert length(listed_quests) == 3
    assert Enum.at(listed_quests, 0).name == "Collect herbs"
  end

  test "filter completed quests" do
    quests = [
      %{name: "Collect herbs", challenge_score: 50, completed: false},
      %{name: "Defeat the dragon", challenge_score: 100, completed: true},
      %{name: "Deliver a message", challenge_score: 75, completed: false}
    ]

    completed_quests = QuestManager.filter_completed(quests)

    assert length(completed_quests) == 1
    assert hd(completed_quests).name == "Defeat the dragon"
  end

  test "filter incomplete quests" do
    quests = [
      %{name: "Collect herbs", challenge_score: 50, completed: false},
      %{name: "Defeat the dragon", challenge_score: 100, completed: true},
      %{name: "Deliver a message", challenge_score: 75, completed: false}
    ]

    incomplete_quests = QuestManager.filter_incomplete(quests)

    assert length(incomplete_quests) == 2
    assert hd(incomplete_quests).name == "Collect herbs"
  end

  test "delete a quest by index" do
    # Initial list of quests
    quests = [
      %{name: "Quest 1", challenge_score: 10, completed: false},
      %{name: "Quest 2", challenge_score: 20, completed: false},
      %{name: "Quest 3", challenge_score: 30, completed: false}
    ]

    # Delete the quest at index 1 (Quest 2)
    modified_quests = QuestManager.delete_by_index(quests, 1)

    # Ensure that the quest at index 1 is deleted
    assert length(modified_quests) == length(quests) - 1
    assert modified_quests == [
      %{name: "Quest 1", challenge_score: 10, completed: false},
      %{name: "Quest 3", challenge_score: 30, completed: false}
    ]
  end
end
