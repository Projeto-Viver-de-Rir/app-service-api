defmodule Database.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :text, null: false
      add :description, :text, null: true
      add :address, :string, null: true
      add :city, :string, null: true
      add :meeting_point, :string, null: true
      add :date_time, :utc_datetime, null: false
      add :occupancy, :string, null: false
      add :status, :string, null: false

      ## Audit related fields
      add :created_at, :utc_datetime, null: false
      add :created_by, :bigint, null: false
      add :updated_at, :utc_datetime, null: true
      add :updated_by, :bigint, null: true
      add :deleted_at, :utc_datetime, null: true
      add :deleted_by, :bigint, null: true
    end
  end
end
