defmodule Domain.Accounts do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [
    :id,
    :name,
    :email,
    :email_confirmed,
    :password_hash,
    :access_failed_count,
    :created_at,
    :created_by
  ]

  @all_fields @required_fields ++
                [
                  :photo_url,
                  :updated_at,
                  :updated_by,
                  :deleted_at,
                  :deleted_by
                ]

  @opaque t :: %__MODULE__{
          id: non_neg_integer() | nil,
          name: String.t(),
          email: String.t(),
          email_confirmed: boolean(),
          password_hash: String.t(),
          access_failed_count: non_neg_integer(),
          photo_url: String.t() | nil,
          created_at: DateTime.t() | nil,
          created_by: String.t() | nil,
          updated_at: DateTime.t() | nil,
          updated_by: String.t() | nil,
          deleted_at: DateTime.t() | nil,
          deleted_by: String.t() | nil
          }

  schema "accounts" do
    field(:name, :string)
    field(:email, :string)
    field(:email_confirmed, :boolean)
    field(:password_hash, :string)
    field(:access_failed_count, :integer)
    field(:photo_url, :string)
    has_one(:volunteers, Domain.Volunteers)

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
         email: params.email,
         email_confirmed: params.email_confirmed,
         password_hash: params.password_hash,
         access_failed_count: params.access_failed_count,
         photo_url: params.photo_url
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

  @spec changeset(Domain.Accounts.t(), :create, String.t()) :: Ecto.Changeset.t()
  def changeset(data, :create, logged_user_id) do
    params = %__MODULE__{
      data
      | created_by: logged_user_id,
        created_at: DateTime.utc_now()
    }

    %__MODULE__{}
    |> cast(Map.from_struct(params), @all_fields)
    |> set_password_hash()
  end

  @spec changeset(
          Domain.Accounts.t(),
          Domain.Accounts.t(),
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
    |> set_password_hash()
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

  defp set_password_hash(%Ecto.Changeset{valid?: true, changes: %{password_hash: password_hash}} = changeset) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password_hash))
  end

  defp set_password_hash(changeset), do: changeset
end
