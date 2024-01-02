defmodule Domain.Volunteers do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [
    :id,
    # :account_id,
    :name,
    :identifier,
    :status,
    :created_at,
    :created_by
  ]

  @all_fields @required_fields ++
                [
                  :nickname,
                  :email,
                  :phone,
                  :address,
                  :city,
                  :state,
                  :zip,
                  :birth_date,
                  :availability,
                  :comments,
                  :updated_at,
                  :updated_by,
                  :deleted_at,
                  :deleted_by
                ]

  @opaque t :: %__MODULE__{
            id: non_neg_integer() | nil,
            name: String.t(),
            nickname: String.t() | nil,
            email: String.t() | nil,
            phone: String.t() | nil,
            address: String.t() | nil,
            city: String.t() | nil,
            state: String.t() | nil,
            zip: String.t() | nil,
            birth_date: DateTime.t() | nil,
            identifier: String.t(),
            availability: String.t() | nil,
            comments: String.t() | nil,
            status: String.t() | nil,
            created_at: DateTime.t() | nil,
            created_by: String.t() | nil,
            updated_at: DateTime.t() | nil,
            updated_by: String.t() | nil,
            deleted_at: DateTime.t() | nil,
            deleted_by: String.t() | nil
          }

  schema "volunteers" do
    field(:name, :string)
    field(:nickname, :string)
    field(:email, :string)
    field(:phone, :string)
    field(:address, :string)
    field(:city, :string)
    field(:state, :string)
    field(:zip, :string)
    field(:birth_date, :utc_datetime)
    field(:identifier, :string)
    field(:availability, :string)
    field(:comments, :string)
    field(:status, :string)

    field(:created_at, :utc_datetime)
    field(:created_by, :integer)
    field(:updated_at, :utc_datetime)
    field(:updated_by, :integer)
    field(:deleted_at, :utc_datetime)
    field(:deleted_by, :integer)
  end

  @spec cast_domain(map()) :: {:ok, t()} | {:error, atom()}
  def cast_domain(params) do
    with {:ok, _} <- check_empty(params.name) do
      {:ok,
       %__MODULE__{
         id: params.id,
         name: params.name,
         nickname: params.nickname,
         email: params.email,
         phone: params.phone,
         address: params.address,
         city: params.city,
         state: params.state,
         zip: params.zip,
         birth_date: params.birth_date,
         identifier: params.identifier,
         availability: params.availability,
         comments: params.comments,
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

  @spec changeset(Domain.Volunteers.t(), :create, String.t()) :: Ecto.Changeset.t()
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
          Domain.Volunteers.t(),
          Domain.Volunteers.t(),
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
