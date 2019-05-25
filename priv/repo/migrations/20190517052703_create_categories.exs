defmodule Dtodoaqui.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :slug, :string
      add :font_icon, :string
      timestamps()
    end

  end
end
