defmodule Mudbot.UserManager do
  @moduledoc """
  A module for managing users and their characters.
  """

  # Structure for a user
  defstruct username: "", id: nil, characters: []

  # Store to keep track of users
  @users %{}

  # Create a new user
  def create_user(username) when is_binary(username) do
    id = :rand.uniform()
    user = %__MODULE__{id: id, username: username, characters: []}
    @users = Map.put(@users, id, user)
    {:ok, user}
  end

  # Retrieve a user by ID
  def get_user(id) when is_integer(id) do
    case Map.fetch(@users, id) do
      {:ok, user} -> {:ok, user}
      :error -> {:error, "User not found"}
    end
  end

  # Update a user's username
  def update_username(id, new_username) when is_integer(id) and is_binary(new_username) do
    case get_user(id) do
      {:ok, user} ->
        updated_user = %{user | username: new_username}
        @users = Map.put(@users, id, updated_user)
        {:ok, updated_user}
      _ ->
        {:error, "User not found"}
    end
  end

  # Add a character to a user's character list
  def add_character(id, character) when is_integer(id) and is_map(character) do
    case get_user(id) do
      {:ok, user} ->
        updated_user = %{user | characters: [character | user.characters]}
        @users = Map.put(@users, id, updated_user)
        {:ok, updated_user}
      _ ->
        {:error, "User not found"}
    end
  end

  # Delete a user by ID
  def delete_user(id) when is_integer(id) do
    case get_user(id) do
      {:ok, _user} ->
        @users = Map.delete(@users, id)
        {:ok, "User deleted"}
      _ ->
        {:error, "User not found"}
    end
  end
end
