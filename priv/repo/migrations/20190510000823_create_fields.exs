defmodule Dtodoaqui.Repo.Migrations.CreateFields do
  use Ecto.Migration

  def change do
    create table(:fields) do
      add :listing_id, :integer
      add :data_key, :string
      add :data_value, :string
      add :created, :utc_datetime
      add :modified, :utc_datetime

      timestamps()
    end

  end
end
