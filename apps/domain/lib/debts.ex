defmodule Domain.Debts do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [
    :id,
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

  @opaque t :: %__MODULE__{
          id: non_neg_integer() | nil,
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

  @spec cast_domain(map()) :: {:ok, t()} | {:error, atom()}
  def cast_domain(params) do
    with {:ok, _} <- check_empty(params.name) do
      {:ok,
       %__MODULE__{
         id: params.id,
         name: params.name,
         description: params.description,
         amount: params.amount,
         due_date: params.due_date,
         volunteer_id: params.volunteer_id,
         paid_at: params.paid_at,
         paid_by: params.paid_by
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

  @spec changeset(Domain.Debts.t(), :create, String.t()) :: Ecto.Changeset.t()
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
          Domain.Debts.t(),
          Domain.Debts.t(),
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
