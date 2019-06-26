defmodule Dtodoaqui.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :review_id, :integer
      add :type, :string
      add :value, :integer
      add :max, :integer
      add :user_id, :integer

      timestamps()
    end

  end
end
