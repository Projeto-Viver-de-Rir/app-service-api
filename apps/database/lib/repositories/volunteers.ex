defmodule Database.Repositories.Volunteers do
  @moduledoc """
  This represents the repository to access volunteers.
  """
  import Ecto.Query

  alias Domain.Volunteers
  alias Database.Repo

  require Logger

  @spec list_volunteers(_filter :: map()) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def list_volunteers(_filter) do
    volunteers =
      from(volunteers in Volunteers)
      |> Repo.all()

    {:ok, volunteers}
  end

  @spec fetch(id :: integer) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def fetch(id) do
    from(volunteers in Volunteers,
      where: volunteers.id == ^id
    )
    |> Repo.one()
    |> case do
      nil -> {:not_found}
      volunteer -> {:ok, volunteer}
    end
  end

  # next step
  # @spec create(volunteer :: Volunteers.t(), repo :: Ecto.Repo.t()) ::
  #         {:ok, Volunteers.t()} | {:error, map()}
  # def create(volunteer, repo) do
  #   volunteer_domain = Volunteers.create(volunteer, 1)

  #   case volunteer_domain.valid? do
  #     false ->
  #       {:error, volunteer_domain.errors}

  #       true ->
  #         repo.insert(volunteer_domain)
  #   end
  # end

  @spec create(volunteer :: Volunteers.t(), logged_user_id :: String.t()) ::
          {:ok, Volunteers.t()} | {:error, map()}
  def create(volunteer, logged_user_id) do
    changeset = Volunteers.changeset(volunteer, :create, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.insert(changeset)
    end
  end

  @spec update(
          previous_data :: Volunteers.t(),
          data :: Volunteers.t(),
          logged_user_id :: String.t()
        ) ::
          {:ok, Volunteers.t()} | {:error, map()}
  def update(previous_data, data, logged_user_id) do
    changeset = Volunteers.changeset(previous_data, data, :update, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  @spec soft_delete(previous_data :: Volunteers.t(), logged_user_id :: String.t()) ::
          {:ok, Volunteers.t()} | {:error, map()}
  def soft_delete(previous_data, logged_user_id) do
    changeset = Volunteers.changeset(previous_data, previous_data, :delete, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  def hard_delete(volunteer) do
    volunteer
    |> Repo.delete()

    {:ok}
  end
end
