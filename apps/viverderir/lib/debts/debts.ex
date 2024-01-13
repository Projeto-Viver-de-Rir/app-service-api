defmodule ViverDeRir.Debts do
  @moduledoc """
  Documentation for `Debts`.
  """

  alias Domain.Debts
  alias Database.Repositories.Debts

  require Logger

  def list_debts(filter) do
    Debts.list_debts(filter)
  end

  def get_debt(debt_id) do
    Debts.fetch(debt_id)
  end

  def create_debt(debt, logged_user_id) do
    Debts.create(debt, logged_user_id)
  end

  def update_debt(debt, logged_user_id) do
    Debts.fetch(debt.id)
    |> case do
      {:not_found} ->
        {:error, "Debt not found"}

      {:ok, existing_data} ->
        Debts.update(existing_data, debt, logged_user_id)
    end
  end

  def delete_debt(debt_id, logged_user_id) do
    Debts.fetch(debt_id)
    |> case do
      {:not_found} ->
        {:error, "Debt not found"}

      {:ok, existing_data} ->
        Debts.soft_delete(existing_data, logged_user_id)
    end
  end
end
