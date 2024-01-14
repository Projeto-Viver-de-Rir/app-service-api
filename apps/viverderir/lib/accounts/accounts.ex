defmodule ViverDeRir.Accounts do
  @moduledoc """
  Documentation for `Accounts`.
  """

  alias Domain.Accounts
  alias Database.Repositories.Accounts

  require Logger

  def list_accounts(filter) do
    Accounts.list_accounts(filter)
  end

  def get_account(account_id) do
    Accounts.fetch(account_id)
  end

  def get_by_email(email) do
    Accounts.get_by_email(email)
  end

  def create_account(account, logged_user_id) do
    Accounts.create(account, logged_user_id)
  end

  def update_account(account, logged_user_id) do
    Accounts.fetch(account.id)
    |> case do
      {:not_found} ->
        {:error, "Account not found"}

      {:ok, existing_data} ->
        Accounts.update(existing_data, account, logged_user_id)
    end
  end

  def delete_account(account_id, logged_user_id) do
    Accounts.fetch(account_id)
    |> case do
      {:not_found} ->
        {:error, "Account not found"}

      {:ok, existing_data} ->
        Accounts.soft_delete(existing_data, logged_user_id)
    end
  end
end
