defmodule Database.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :text, null: false
      add :description, :text, null: true
      add :status, :string, null: false
      add :members, {:array, :integer}, null: false, default: []

      ## Audit related fields
      add :created_at, :utc_datetime, null: false
      add :created_by, :string, null: false
      add :updated_at, :utc_datetime, null: true
      add :updated_by, :string, null: true
      add :deleted_at, :utc_datetime, null: true
      add :deleted_by, :string, null: true
    end
  end
end
