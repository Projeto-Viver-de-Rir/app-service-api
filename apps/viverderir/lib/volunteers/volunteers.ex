defmodule ViverDeRir.Volunteers do
  @moduledoc """
  Documentation for `Volunteers`.
  """

  alias Database.Domain.Volunteers
  alias Database.Repositories.Volunteers

  require Logger

  def list_volunteers(filter) do
    Volunteers.list_volunteers(filter)
  end

  def get_volunteer(volunteer_id) do
    Volunteers.fetch(volunteer_id)
  end

  def create_volunteer(volunteer) do
    Volunteers.create(volunteer)
  end

  def update_volunteer(volunteer) do
    Volunteers.fetch(volunteer.id)
    |> case do
      {:not_found} ->
        {:error, "Volunteer not found"}

      {:ok, existing_data} ->
        Volunteers.update(existing_data, volunteer)
    end
  end

  def delete_volunteer(volunteer_id) do
    Volunteers.delete(volunteer_id)
  end
end
