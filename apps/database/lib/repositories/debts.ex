defmodule Database.Repositories.Debts do
  @moduledoc """
  This represents the repository to access debts.
  """
  import Ecto.Query

  alias Domain.Debts
  alias Database.Repo

  require Logger

  @spec list_debts(_filter :: map()) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def list_debts(_filter) do
    debts =
      from(debts in Debts,
      where: is_nil(debts.deleted_at)
      )
      |> Repo.all()

    {:ok, debts}
  end

  @spec fetch(id :: integer) ::
          {:ok, list(Configuration.t())} | {:error, map()}
  def fetch(id) do
    from(debts in Debts,
      where: debts.id == ^id
    )
    |> Repo.one()
    |> case do
      nil -> {:not_found}
      debt -> {:ok, debt}
    end
  end

  # next step
  # @spec create(debt :: Debts.t(), repo :: Ecto.Repo.t()) ::
  #         {:ok, Debts.t()} | {:error, map()}
  # def create(debt, repo) do
  #   debt_domain = Debts.create(debt, 1)

  #   case debt_domain.valid? do
  #     false ->
  #       {:error, debt_domain.errors}

  #       true ->
  #         repo.insert(debt_domain)
  #   end
  # end

  @spec create(debt :: Debts.t(), logged_user_id :: String.t()) ::
          {:ok, Debts.t()} | {:error, map()}
  def create(debt, logged_user_id) do
    changeset = Debts.changeset(debt, :create, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.insert(changeset)
    end
  end

  @spec update(
          previous_data :: Debts.t(),
          data :: Debts.t(),
          logged_user_id :: String.t()
        ) ::
          {:ok, Debts.t()} | {:error, map()}
  def update(previous_data, data, logged_user_id) do
    changeset = Debts.changeset(previous_data, data, :update, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  @spec soft_delete(previous_data :: Debts.t(), logged_user_id :: String.t()) ::
          {:ok, Debts.t()} | {:error, map()}
  def soft_delete(previous_data, logged_user_id) do
    changeset = Debts.changeset(previous_data, previous_data, :delete, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  def hard_delete(debt) do
    debt
    |> Repo.delete()

    {:ok}
  end
end
