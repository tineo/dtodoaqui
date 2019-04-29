defmodule Dtodoaqui.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :location_id, :integer
      add :image_name, :string
      add :name, :string
      add :slug, :string
      add :is_verified, :boolean, default: false, null: false
      add :created, :utc_datetime
      add :modified, :utc_datetime

      timestamps()
    end

  end
end
