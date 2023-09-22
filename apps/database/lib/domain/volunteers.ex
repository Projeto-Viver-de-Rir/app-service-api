defmodule Database.Domain.Volunteers do
  @moduledoc """
  This represents the domain volunteer in our database.
  """
  use Ecto.Schema

  @required_fields [
    :volunteer_id,
    :account_id,
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

  @type t :: %__MODULE__{
          volunteer_id: non_neg_integer() | nil,
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
    field(:volunteer_id, :integer)
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
    field(:created_by, :string)
    field(:updated_at, :utc_datetime)
    field(:updated_by, :string)
    field(:deleted_at, :utc_datetime)
    field(:deleted_by, :string)
  end

  @spec create(t(), integer()) :: t()
  def create(self = %__MODULE__{}, logged_account_id) do
    %__MODULE__{
      self
      | created_by: logged_account_id,
        updated_by: logged_account_id
    }
  end

  @spec update(t(), integer()) :: t()
  def update(self = %__MODULE__{}, logged_account_id) do
    %__MODULE__{
      self
      | updated_at: logged_account_id,
        updated_by: logged_account_id
    }
  end

  @spec delete(t(), integer()) :: t()
  def delete(self = %__MODULE__{}, logged_account_id) do
    %__MODULE__{
      self
      | updated_at: logged_account_id,
        updated_by: logged_account_id,
        deleted_by: logged_account_id,
        deleted_at: DateTime.utc_now()
    }
  end
end
