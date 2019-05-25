defmodule Dtodoaqui.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :entity_id, :integer
      add :entity_name, :string
      add :image_name, :string
      timestamps()
    end

  end
end
