defmodule Dtodoaqui.Directories.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :created, :utc_datetime
    field :image_name, :string
    field :is_verified, :boolean, default: false
    field :location_id, :integer
    field :modified, :utc_datetime
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:location_id, :image_name, :name, :slug, :is_verified, :created, :modified])
    |> validate_required([:location_id, :image_name, :name, :slug, :is_verified, :created, :modified])
  end
end
