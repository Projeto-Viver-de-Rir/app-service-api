defmodule Database.Domain.Events do
  @moduledoc """
  This represents the domain event in our database.
  """
  use Ecto.Schema

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

  @type t :: %__MODULE__{
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
