defmodule Dtodoaqui.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :image_name, :string
      add :name, :string
      add :slug, :string
      add :is_verified, :boolean, default: false, null: false
      timestamps()
    end

  end
end
