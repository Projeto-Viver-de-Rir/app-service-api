defmodule Database.Repositories.Events do
  @moduledoc """
  This represents the repository to access events.
  """
  import Ecto.Query

  alias Domain.Events
  alias Database.Repo

  require Logger

  @spec list_events(_filter :: map()) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def list_events(_filter) do
    events =
      from(events in Events,
      where: is_nil(events.deleted_at)
      )
      |> Repo.all()

    {:ok, events}
  end

  @spec fetch(id :: integer) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def fetch(id) do
    from(events in Events,
      where: events.id == ^id
    )
    |> Repo.one()
    |> case do
      nil -> {:not_found}
      event -> {:ok, event}
    end
  end

  # next step
  # @spec create(event :: Events.t(), repo :: Ecto.Repo.t()) ::
  #         {:ok, Events.t()} | {:error, map()}
  # def create(event, repo) do
  #   event_domain = Events.create(event, 1)

  #   case event_domain.valid? do
  #     false ->
  #       {:error, event_domain.errors}

  #       true ->
  #         repo.insert(event_domain)
  #   end
  # end

  @spec create(event :: Events.t(), logged_user_id :: String.t()) ::
          {:ok, Events.t()} | {:error, map()}
  def create(event, logged_user_id) do
    changeset = Events.changeset(event, :create, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.insert(changeset)
    end
  end

  @spec update(
          previous_data :: Events.t(),
          data :: Events.t(),
          logged_user_id :: String.t()
        ) ::
          {:ok, Events.t()} | {:error, map()}
  def update(previous_data, data, logged_user_id) do
    changeset = Events.changeset(previous_data, data, :update, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  @spec soft_delete(previous_data :: Events.t(), logged_user_id :: String.t()) ::
          {:ok, Events.t()} | {:error, map()}
  def soft_delete(previous_data, logged_user_id) do
    changeset = Events.changeset(previous_data, previous_data, :delete, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  def hard_delete(event) do
    event
    |> Repo.delete()

    {:ok}
  end
end
