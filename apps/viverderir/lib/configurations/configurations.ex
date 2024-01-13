defmodule ViverDeRir.Configurations do
  @moduledoc """
  Documentation for `Configurations`.
  """

  alias Domain.Configurations
  alias Database.Repositories.Configurations

  require Logger

  def list_configurations(filter) do
    Configurations.list_configurations(filter)
  end

  def get_configuration(configuration_id) do
    Configurations.fetch(configuration_id)
  end

  def create_configuration(configuration, logged_user_id) do
    Configurations.create(configuration, logged_user_id)
  end

  def update_configuration(configuration, logged_user_id) do
    Configurations.fetch(configuration.id)
    |> case do
      {:not_found} ->
        {:error, "Configuration not found"}

      {:ok, existing_data} ->
        Configurations.update(existing_data, configuration, logged_user_id)
    end
  end

  def delete_configuration(configuration_id, logged_user_id) do
    Configurations.fetch(configuration_id)
    |> case do
      {:not_found} ->
        {:error, "Configuration not found"}

      {:ok, existing_data} ->
        Configurations.soft_delete(existing_data, logged_user_id)
    end
  end
end
