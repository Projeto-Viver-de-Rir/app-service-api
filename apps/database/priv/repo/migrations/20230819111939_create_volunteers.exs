defmodule Database.Repo.Migrations.CreateVolunteers do
  use Ecto.Migration

  def change do
    create table(:volunteers) do
      add :volunteer_id, :bigint, null: false
      add :name, :text, null: false
      add :nickname, :text, null: true
      add :email, :string, null: true
      add :phone, :string, null: true
      add :address, :string, null: true
      add :city, :string, null: true
      add :state, :string, null: true
      add :zip, :string, null: true
      add :birth_date, :utc_datetime, null: true
      add :identifier, :string, null: false
      add :availability, :string, null: true
      add :comments, :string, null: true
      add :status, :string, null: false

      ## Foreign Key
      add :account_id, references(:accounts, on_delete: :delete_all)

      ## Audit related fields
      add :created_at, :utc_datetime, null: false
      add :created_by, :bigint, null: false
      add :updated_at, :utc_datetime, null: true
      add :updated_by, :bigint, null: true
      add :deleted_at, :utc_datetime, null: true
      add :deleted_by, :bigint, null: true
    end

    create index(:volunteers, [:volunteer_id], unique: true, name: :idx_volunteers_volunteer_id)
  end
end
