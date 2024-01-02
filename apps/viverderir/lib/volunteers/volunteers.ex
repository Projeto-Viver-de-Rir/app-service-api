defmodule ViverDeRir.Volunteers do
  @moduledoc """
  Documentation for `Volunteers`.
  """

  alias Domain.Volunteers
  alias Database.Repositories.Volunteers

  require Logger

  def list_volunteers(filter) do
    Volunteers.list_volunteers(filter)
  end

  def get_volunteer(volunteer_id) do
    Volunteers.fetch(volunteer_id)
  end

  def create_volunteer(volunteer, logged_user_id) do
    Volunteers.create(volunteer, logged_user_id)
  end

  def update_volunteer(volunteer, logged_user_id) do
    Volunteers.fetch(volunteer.id)
    |> case do
      {:not_found} ->
        {:error, "Volunteer not found"}

      {:ok, existing_data} ->
        Volunteers.update(existing_data, volunteer, logged_user_id)
    end
  end

  def delete_volunteer(volunteer_id, logged_user_id) do
    Volunteers.fetch(volunteer_id)
    |> case do
      {:not_found} ->
        {:error, "Volunteer not found"}

      {:ok, existing_data} ->
        Volunteers.soft_delete(existing_data, logged_user_id)
    end
  end
end
