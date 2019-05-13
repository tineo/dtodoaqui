defmodule Dtodoaqui.Repo.Migrations.UserIdInLocation do
  use Ecto.Migration

  def change do
    alter table("locations") do
      remove :location_id
      add :user_id, :integer
    end
    #rename table("locations"), :location_id, to: :user_id
  end
end
