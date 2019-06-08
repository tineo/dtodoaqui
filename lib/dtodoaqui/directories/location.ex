defmodule Dtodoaqui.Directories.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :image_name, :string
    field :is_verified, :boolean, default: false
    field :user_id, :integer
    field :name, :string
    field :district, :string
    field :address, :string
    field :slug, :string
    field :latitude, :decimal
    field :longitude, :decimal

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:user_id, :image_name, :name, :address, :slug, :is_verified, :district, :latitude, :longitude])
    |> validate_required([:image_name, :name, :latitude, :longitude, :slug])
  end
end
