defmodule Dtodoaqui.Directories.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :created, :utc_datetime
    field :image_name, :string
    field :is_verified, :boolean, default: false
    field :user_id, :integer
    field :modified, :utc_datetime
    field :name, :string
    field :district, :string
    field :slug, :string
    field :latitude, :decimal
    field :longitude, :decimal

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:user_id, :image_name, :name, :address, :slug, :is_verified, :created, :modified, :district])
    |> validate_required([:user_id, :image_name, :name, :address, :slug, :is_verified,  :created, :modified])
  end
end
