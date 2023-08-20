defmodule Database.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :team_id, :bigint, null: false
      add :name, :text, null: false
      add :description, :text, null: true
      add :status, :string, null: false

      ## Audit related fields
      add :created_at, :utc_datetime, null: false
      add :created_by, :bigint, null: false
      add :updated_at, :utc_datetime, null: true
      add :updated_by, :bigint, null: true
      add :deleted_at, :utc_datetime, null: true
      add :deleted_by, :bigint, null: true
  end

  create index(:teams, [:team_id], unique: true, name: :idx_teams_team_id)
end
