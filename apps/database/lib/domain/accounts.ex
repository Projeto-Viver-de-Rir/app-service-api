defmodule Database.Domain.Accounts do
  @moduledoc """
  This represents the domain account in our database.
  """
  use Ecto.Schema

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

  @type t :: %__MODULE__{
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
