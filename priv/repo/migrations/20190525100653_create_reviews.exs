defmodule Dtodoaqui.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :user_id, :integer
      add :listing_id, :integer
      add :name, :string
      add :description, :string
      add :is_published, :boolean

      timestamps()
    end

  end
end
