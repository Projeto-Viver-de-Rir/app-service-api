defmodule Database.Repo.Migrations.CreateDebts do
  use Ecto.Migration

  def change do
    create table(:debts) do
      add :name, :text, null: false
      add :description, :text, null: true
      add :amount, :float, null: false, default: 0.0
      add :due_date, :utc_datetime, null: false
      add :paid_at, :utc_datetime, null: true

      ## Foreign Key
      add :volunteer_id, references(:volunteers, on_delete: :delete_all)
      add :paid_by, references(:volunteers, on_delete: :nothing)

      ## Audit related fields
      add :created_at, :utc_datetime, null: false
      add :created_by, :integer, null: false
      add :updated_at, :utc_datetime, null: true
      add :updated_by, :bigint, null: true
      add :deleted_at, :utc_datetime, null: true
      add :deleted_by, :bigint, null: true
    end
  end
end
