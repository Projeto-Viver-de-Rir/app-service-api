defmodule Database.Repositories.Accounts do
  @moduledoc """
  This represents the repository to access accounts.
  """
  import Ecto.Query

  alias Domain.Accounts
  alias Database.Repo

  require Logger

  @spec list_accounts(_filter :: map()) ::
          {:ok, list(Accounts.t())} | {:error, map()}
  def list_accounts(_filter) do
    accounts =
      from(accounts in Accounts,
      where: is_nil(accounts.deleted_at)
      )
      |> Repo.all()

    {:ok, accounts}
  end

  @spec fetch(id :: integer) ::
          {:ok, list(Accounts.t())} | {:error, map()}
  def fetch(id) do
    from(accounts in Accounts,
      where: accounts.id == ^id
    )
    |> Repo.one()
    |> case do
      nil -> {:not_found}
      account -> {:ok, account}
    end
  end

  @spec get_by_email(email :: String.t()) ::
          {:ok, Accounts.t()} | {:error, :not_found}
  def get_by_email(email) do
    from(accounts in Accounts,
      where: accounts.email == ^email
    )
    |> Repo.one()
    |> case do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end

  # next step
  # @spec create(account :: Accounts.t(), repo :: Ecto.Repo.t()) ::
  #         {:ok, Accounts.t()} | {:error, map()}
  # def create(account, repo) do
  #   account_domain = Accounts.create(account, 1)

  #   case account_domain.valid? do
  #     false ->
  #       {:error, account_domain.errors}

  #       true ->
  #         repo.insert(account_domain)
  #   end
  # end

  @spec create(account :: Accounts.t(), logged_user_id :: String.t()) ::
          {:ok, Accounts.t()} | {:error, map()}
  def create(account, logged_user_id) do
    changeset = Accounts.changeset(account, :create, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.insert(changeset)
    end
  end

  @spec update(
          previous_data :: Accounts.t(),
          data :: Accounts.t(),
          logged_user_id :: String.t()
        ) ::
          {:ok, Accounts.t()} | {:error, map()}
  def update(previous_data, data, logged_user_id) do
    changeset = Accounts.changeset(previous_data, data, :update, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  @spec soft_delete(previous_data :: Accounts.t(), logged_user_id :: String.t()) ::
          {:ok, Accounts.t()} | {:error, map()}
  def soft_delete(previous_data, logged_user_id) do
    changeset = Accounts.changeset(previous_data, previous_data, :delete, logged_user_id)

    case changeset.valid? do
      false ->
        {:error, changeset}

      true ->
        Repo.update(changeset)
    end
  end

  def hard_delete(account) do
    account
    |> Repo.delete()

    {:ok}
  end
end
