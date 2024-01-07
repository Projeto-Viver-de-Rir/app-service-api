defmodule Database.Repositories.Teams do
  @moduledoc """
  This represents the repository to access teams.
  """
  import Ecto.Query

  alias Domain.Teams
  alias Database.Repo

  require Logger

  @spec list_teams(_filter :: map()) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def list_teams(_filter) do
    teams =
      from(teams in Teams,
      where: is_nil(teams.deleted_at)
      )
      |> Repo.all()

    {:ok, teams}
  end

  @spec fetch(id :: integer) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def fetch(id) do
    from(teams in Teams,
      where: teams.id == ^id
    )
    |> Repo.one()
    |> case do
      nil -> {:not_found}
      team -> {:ok, team}
    end
  end

  # next step
  # @spec create(team :: Teams.t(), repo :: Ecto.Repo.t()) ::
  #         {:ok, Teams.t()} | {:error, map()}
  # def create(team, repo) do
  #   team_domain = Teams.create(team, 1)

  #   case team_domain.valid? do
  #     false ->
  #       {:error, team_domain.errors}

  #       true ->
  #         repo.insert(team_domain)
  #   end
  # end

  @spec create(team :: Teams.t(), logged_user_id :: String.t()) ::
          {:ok, Teams.t()} | {:error, map()}
  def create(team, logged_user_id) do
    changeset = Teams.changeset(team, :create, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.insert(changeset)
    end
  end

  @spec update(
          previous_data :: Teams.t(),
          data :: Teams.t(),
          logged_user_id :: String.t()
        ) ::
          {:ok, Teams.t()} | {:error, map()}
  def update(previous_data, data, logged_user_id) do
    changeset = Teams.changeset(previous_data, data, :update, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  @spec soft_delete(previous_data :: Teams.t(), logged_user_id :: String.t()) ::
          {:ok, Teams.t()} | {:error, map()}
  def soft_delete(previous_data, logged_user_id) do
    changeset = Teams.changeset(previous_data, previous_data, :delete, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  def hard_delete(team) do
    team
    |> Repo.delete()

    {:ok}
  end
end
