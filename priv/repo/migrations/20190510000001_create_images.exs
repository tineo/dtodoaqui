defmodule Dtodoaqui.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :listing_id, :integer
      add :image_name, :string
      timestamps()
    end

  end
end
