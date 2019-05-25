defmodule Dtodoaqui.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :review_id, :integer
      add :type, :string
      add :value, :integer
      add :max, :integer

      timestamps()
    end

  end
end
