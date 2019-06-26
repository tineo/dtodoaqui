defmodule Dtodoaqui.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :user_id, :integer
      add :listing_id, :integer
      add :message, :string
      add :is_approved, :boolean, default: false, null: false

      timestamps()
    end

  end
end
