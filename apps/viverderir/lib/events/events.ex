defmodule ViverDeRir.Events do
  @moduledoc """
  Documentation for `Events`.
  """

  alias Domain.Events
  alias Database.Repositories.Events

  require Logger

  def list_events(filter) do
    Events.list_events(filter)
  end

  def get_event(event_id) do
    Events.fetch(event_id)
  end

  def create_event(event, logged_user_id) do
    Events.create(event, logged_user_id)
  end

  def update_event(event, logged_user_id) do
    Events.fetch(event.id)
    |> case do
      {:not_found} ->
        {:error, "Event not found"}

      {:ok, existing_data} ->
        Events.update(existing_data, event, logged_user_id)
    end
  end

  def delete_event(event_id, logged_user_id) do
    Events.fetch(event_id)
    |> case do
      {:not_found} ->
        {:error, "Event not found"}

      {:ok, existing_data} ->
        Events.soft_delete(existing_data, logged_user_id)
    end
  end
end
