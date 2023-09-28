defmodule Mudbot.CharacterManager do
  @moduledoc """
  A module for managing characters and their quests.
  """

  # Structure for a character
  defstruct name: "", id: nil, quests: []

  # Store to keep track of characters
  @characters %{}

  # Create a new character
  def create_character(name) when is_binary(name) do
    id = :rand.uniform()
    character = %__MODULE__{id: id, name: name, quests: []}
    @characters = Map.put(@characters, id, character)
    {:ok, character}
  end

  # Retrieve a character by ID
  def get_character(id) when is_integer(id) do
    case Map.fetch(@characters, id) do
      {:ok, character} -> {:ok, character}
      :error -> {:error, "Character not found"}
    end
  end

  # Update a character's name
  def update_character_name(id, new_name) when is_integer(id) and is_binary(new_name) do
    case get_character(id) do
      {:ok, character} ->
        updated_character = %{character | name: new_name}
        @characters = Map.put(@characters, id, updated_character)
        {:ok, updated_character}
      _ ->
        {:error, "Character not found"}
    end
  end

  # Add a quest to a character's quest list
  def add_quest(id, quest) when is_integer(id) and is_binary(quest) do
    case get_character(id) do
      {:ok, character} ->
        updated_character = %{character | quests: [quest | character.quests]}
        @characters = Map.put(@characters, id, updated_character)
        {:ok, updated_character}
      _ ->
        {:error, "Character not found"}
    end
  end

  # Delete a character by ID
  def delete_character(id) when is_integer(id) do
    case get_character(id) do
      {:ok, _character} ->
        @characters = Map.delete(@characters, id)
        {:ok, "Character deleted"}
      _ ->
        {:error, "Character not found"}
    end
  end
end
