defmodule ViverDeRir.Teams do
  @moduledoc """
  Documentation for `Teams`.
  """

  alias Domain.Teams
  alias Database.Repositories.Teams

  require Logger

  def list_teams(filter) do
    Teams.list_teams(filter)
  end

  def get_team(team_id) do
    Teams.fetch(team_id)
  end

  def create_team(team, logged_user_id) do
    Teams.create(team, logged_user_id)
  end

  def update_team(team, logged_user_id) do
    Teams.fetch(team.id)
    |> case do
      {:not_found} ->
        {:error, "Team not found"}

      {:ok, existing_data} ->
        Teams.update(existing_data, team, logged_user_id)
    end
  end

  def delete_team(team_id, logged_user_id) do
    Teams.fetch(team_id)
    |> case do
      {:not_found} ->
        {:error, "Team not found"}

      {:ok, existing_data} ->
        Teams.soft_delete(existing_data, logged_user_id)
    end
  end
end
