defmodule Database.Domain.Debts do
  @moduledoc """
  This represents the domain debt in our database.
  """
  use Ecto.Schema

  @required_fields [
    :debt_id,
    :name,
    :amount,
    :due_date,
    :created_at,
    :created_by
  ]

  @all_fields @required_fields ++
                [
                  :description,
                  :paid_at,
                  :paid_by,
                  :updated_at,
                  :updated_by,
                  :deleted_at,
                  :deleted_by
                ]

  @type t :: %__MODULE__{
          debt_id: non_neg_integer() | nil,
          name: String.t(),
          description: String.t() | nil,
          amount: float(),
          due_date: DateTime.t(),
          volunteer_id: non_neg_integer(),
          paid_at: DateTime.t() | nil,
          paid_by: non_neg_integer() | nil,

          created_at: DateTime.t() | nil,
          created_by: String.t() | nil,
          updated_at: DateTime.t() | nil,
          updated_by: String.t() | nil,
          deleted_at: DateTime.t() | nil,
          deleted_by: String.t() | nil
        }

  schema "debts" do
    field(:debt_id, :integer)
    field(:name, :string)
    field(:description, :string)
    field(:amount, :float)
    field(:due_date, :utc_datetime)
    field(:paid_at, :utc_datetime)
    field(:volunteer_id, :integer)
    field(:paid_by, :integer)

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
