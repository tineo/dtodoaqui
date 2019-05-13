defmodule Dtodoaqui.Accounts.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :address, :string
    field :avatar_name, :string
    field :country, :string
    field :created, :utc_datetime
    field :description, :string
    field :facebook, :string
    field :first_name, :string
    field :last_name, :string
    field :linkedin, :string
    field :modified, :utc_datetime
    field :phone, :string
    field :twitter, :string
    field :user_id, :integer
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:user_id, :avatar_name, :first_name, :last_name, :country, :address, :description, :phone, :website, :facebook, :twitter, :linkedin, :created, :modified])
    |> validate_required([:user_id, :first_name, :last_name, :created, :modified])
  end
end
