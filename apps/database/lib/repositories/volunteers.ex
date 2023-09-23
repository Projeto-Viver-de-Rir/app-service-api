defmodule Database.Repositories.Volunteers do
  @moduledoc """
  This represents the repository to access volunteers.
  """
  import Ecto.Query

  alias Database.Domain.Volunteers
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

  @spec create(volunteer :: Volunteers.t()) ::
          {:ok, Volunteers.t()} | {:error, map()}
  def create(volunteer) do
    validation = Volunteers.validate(volunteer)

    case validation.valid? do
      false ->
        {:error, validation}

      true ->
        Repo.insert(volunteer)
    end
  end

  # @spec update(volunteer :: Volunteers.t()) ::
  #         {:ok, Volunteers.t()} | {:error, map()}
  def update(existing_data, replacement_data) do
    Volunteers.validate_ud(existing_data, replacement_data)
    |> Repo.update()
  end

  @spec delete(id :: integer()) ::
          {:ok, Volunteers.t()} | {:error, map()}
  def delete(id) do
    from(volunteers in Volunteers,
      where: volunteers.id == ^id
    )
    |> Repo.one()
    |> case do
      nil -> {:ok}
      volunteer ->
        volunteer |>
        Repo.delete()
        {:ok}
      end
  end
end
