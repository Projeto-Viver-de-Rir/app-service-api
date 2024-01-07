defmodule Domain.Events do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [
    :id,
    :name,
    :date_time,
    :occupancy,
    :status,
    :created_at,
    :created_by
  ]

  @all_fields @required_fields ++
                [
                  :description,
                  :address,
                  :city,
                  :meeting_point,
                  :updated_at,
                  :updated_by,
                  :deleted_at,
                  :deleted_by
                ]

  @opaque t :: %__MODULE__{
          id: non_neg_integer() | nil,
          name: String.t(),
          description: String.t() | nil,
          address: String.t() | nil,
          city: String.t() | nil,
          meeting_point: String.t() | nil,
          date_time: DateTime.t(),
          occupancy: non_neg_integer(),
          status: String.t() | nil,
          created_at: DateTime.t() | nil,
          created_by: String.t() | nil,
          updated_at: DateTime.t() | nil,
          updated_by: String.t() | nil,
          deleted_at: DateTime.t() | nil,
          deleted_by: String.t() | nil
          }

  schema "events" do
    field(:name, :string)
    field(:description, :string)
    field(:address, :string)
    field(:city, :string)
    field(:meeting_point, :string)
    field(:date_time, :utc_datetime)
    field(:occupancy, :integer)
    field(:status, :string)

    field(:created_at, :utc_datetime)
    field(:created_by, :string)
    field(:updated_at, :utc_datetime)
    field(:updated_by, :string)
    field(:deleted_at, :utc_datetime)
    field(:deleted_by, :string)
  end

  @spec cast_domain(map()) :: {:ok, t()} | {:error, atom()}
  def cast_domain(params) do
    with {:ok, _} <- check_empty(params.name) do
      {:ok,
       %__MODULE__{
         id: params.id,
         name: params.name,
         description: params.description,
         address: params.address,
         city: params.city,
         meeting_point: params.meeting_point,
         date_time: params.date_time,
         occupancy: params.occupancy,
         status: params.status
       }}
    else
      {:error, _} ->
        {:error, :validation_failed}
    end
  end

  defp check_empty(param) do
    if String.trim(param) == "" do
      {:error, nil}
    else
      {:ok, String.trim(param)}
    end
  end

  @spec changeset(Domain.Events.t(), :create, String.t()) :: Ecto.Changeset.t()
  def changeset(data, :create, logged_user_id) do
    params = %__MODULE__{
      data
      | created_by: logged_user_id,
        created_at: DateTime.utc_now()
    }

    %__MODULE__{}
    |> cast(Map.from_struct(params), @all_fields)
  end

  @spec changeset(
          Domain.Events.t(),
          Domain.Events.t(),
          :delete | :update,
          String.t()
        ) :: Ecto.Changeset.t()
  def changeset(previous_data, data, :update, logged_user_id) do
    params = %__MODULE__{
      data
      | updated_at: DateTime.utc_now(),
        updated_by: logged_user_id
    }

    previous_data
    |> cast(
      Map.from_struct(params),
      @all_fields -- [:created_at, :created_by, :deleted_at, :deleted_by]
    )
  end

  def changeset(previous_data, data, :delete, logged_user_id) do
    params = %__MODULE__{
      data
      | updated_at: DateTime.utc_now(),
        updated_by: logged_user_id,
        deleted_by: logged_user_id,
        deleted_at: DateTime.utc_now()
    }

    previous_data
    |> cast(Map.from_struct(params), [:updated_at, :updated_by, :deleted_at, :deleted_by])
  end
end
