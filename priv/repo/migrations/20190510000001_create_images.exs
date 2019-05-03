defmodule Dtodoaqui.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :listing_id, :integer
      add :image_name, :string
      add :created, :utc_datetime
      add :modified, :utc_datetime

      timestamps()
    end

  end
end
