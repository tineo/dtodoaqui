defmodule Dtodoaqui.Repo.Migrations.CreateListings do
  use Ecto.Migration

  def change do
    create table(:listings) do
      add :user_id, :integer
      add :category_id, :integer
      add :location_id, :integer
      add :name, :string
      add :type, :string
      add :slug, :string
      add :description, :string
      add :address, :string
      add :price, :float
      add :latitude, :float
      add :longitude, :float
      add :video_youtube, :string
      add :opening_hours, :string
      add :is_verified, :boolean, default: false, null: false
      add :is_featured, :boolean, default: false, null: false
      add :featured_until, :utc_datetime
      add :is_published_until, :boolean, default: false, null: false
      add :published_until, :utc_datetime
      timestamps()
    end

  end
end
