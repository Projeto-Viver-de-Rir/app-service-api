defmodule Database.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :account_id, :bigint, null: false
      add :name, :text, null: false
      add :email, :string, null: false
      add :email_confirmed, :boolean, null: false, default: false
      add :password_hash, :string, null: false
      add :access_failed_count, :integer, null: false, default: 0
      add :photo_url, :string, null: true

      ## Audit related fields
      add :created_at, :utc_datetime, null: false
      add :created_by, :bigint, null: false
      add :updated_at, :utc_datetime, null: true
      add :updated_by, :bigint, null: true
      add :deleted_at, :utc_datetime, null: true
      add :deleted_by, :bigint, null: true
  end

  create index(:accounts, [:account_id], unique: true, name: :idx_accounts_account_id)
  create index(:accounts, [:email], unique: true, name: :idx_accounts_email)
end
