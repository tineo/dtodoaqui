defmodule Dtodoaqui.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :user_id, :integer
      add :avatar_name, :string
      add :first_name, :string
      add :last_name, :string
      add :country, :string
      add :address, :string
      add :description, :string
      add :phone, :string
      add :website, :string
      add :facebook, :string
      #add :twitter, :string
      #add :linkedin, :string
      timestamps()
    end

  end
end
