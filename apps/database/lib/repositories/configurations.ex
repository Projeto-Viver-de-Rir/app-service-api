defmodule Database.Repositories.Configurations do
  @moduledoc """
  This represents the repository to access configurations.
  """
  import Ecto.Query

  alias Domain.Configurations
  alias Database.Repo

  require Logger

  @spec list_configurations(_filter :: map()) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def list_configurations(_filter) do
    configurations =
      from(configurations in Configurations,
      where: is_nil(configurations.deleted_at)
      )
      |> Repo.all()

    {:ok, configurations}
  end

  @spec fetch(id :: integer) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def fetch(id) do
    from(configurations in Configurations,
      where: configurations.id == ^id
    )
    |> Repo.one()
    |> case do
      nil -> {:not_found}
      configuration -> {:ok, configuration}
    end
  end

  # next step
  # @spec create(configuration :: Configurations.t(), repo :: Ecto.Repo.t()) ::
  #         {:ok, Configurations.t()} | {:error, map()}
  # def create(configuration, repo) do
  #   configuration_domain = Configurations.create(configuration, 1)

  #   case configuration_domain.valid? do
  #     false ->
  #       {:error, configuration_domain.errors}

  #       true ->
  #         repo.insert(configuration_domain)
  #   end
  # end

  @spec create(configuration :: Configurations.t(), logged_user_id :: String.t()) ::
          {:ok, Configurations.t()} | {:error, map()}
  def create(configuration, logged_user_id) do
    changeset = Configurations.changeset(configuration, :create, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.insert(changeset)
    end
  end

  @spec update(
          previous_data :: Configurations.t(),
          data :: Configurations.t(),
          logged_user_id :: String.t()
        ) ::
          {:ok, Configurations.t()} | {:error, map()}
  def update(previous_data, data, logged_user_id) do
    changeset = Configurations.changeset(previous_data, data, :update, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  @spec soft_delete(previous_data :: Configurations.t(), logged_user_id :: String.t()) ::
          {:ok, Configurations.t()} | {:error, map()}
  def soft_delete(previous_data, logged_user_id) do
    changeset = Configurations.changeset(previous_data, previous_data, :delete, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  def hard_delete(configuration) do
    configuration
    |> Repo.delete()

    {:ok}
  end
end
