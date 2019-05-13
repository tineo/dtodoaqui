defmodule Dtodoaqui.Repo.Migrations.LatLng do
  use Ecto.Migration

  def change do
    alter table("locations") do
      #remove :location_id
      add :address, :string
      add :latitude, :double
      add :longitude, :double
      remove :inserted_at
      remove :updated_at
    end

  end
end
