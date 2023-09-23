defmodule Database.Domain.Volunteers do
  @moduledoc """
  This represents the domain volunteer in our database.
  """
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

  @ud_fields @all_fields -- [:id, :created_at, :created_by]

  @type t :: %__MODULE__{
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

  @spec validate(volunteer :: __MODULE__.t()) :: Ecto.Changeset.t()
  def validate(volunteer) do
    %__MODULE__{}
    |> cast(Map.from_struct(volunteer), @all_fields)
  end

  @spec validate_ud(volunteer :: __MODULE__.t(), volunteer :: __MODULE__.t()) :: Ecto.Changeset.t()
  def validate_ud(volunteer_old, volunteer_new) do
    volunteer_old
    |> cast(Map.from_struct(volunteer_new), @ud_fields)
  end

  @spec create(Database.Domain.Volunteers.t(), nil) :: Ecto.Changeset.t()
  def create(self = %__MODULE__{}, logged_account_id) do
    %__MODULE__{
      self
      | created_by: logged_account_id,
        created_at: DateTime.utc_now()
    }
    |> validate()
  end

  @spec update(Database.Domain.Volunteers.t(), nil) :: Ecto.Changeset.t()
  def update(self = %__MODULE__{}, logged_account_id) do
    %__MODULE__{
      self
      | updated_at: DateTime.utc_now(),
        updated_by: logged_account_id
    }
  end

  @spec delete(Database.Domain.Volunteers.t(), nil) :: Ecto.Changeset.t()
  def delete(self = %__MODULE__{}, logged_account_id) do
    %__MODULE__{
      self
      | updated_at: DateTime.utc_now(),
        updated_by: logged_account_id,
        deleted_by: logged_account_id,
        deleted_at: DateTime.utc_now()
    }
    |> validate()
  end
end
