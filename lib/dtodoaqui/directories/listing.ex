defmodule Dtodoaqui.Directories.Listing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "listings" do
    field :address, :string
    field :category_id, :integer
    field :created, :utc_datetime
    field :description, :string
    field :featured_until, :utc_datetime
    field :is_featured, :boolean, default: false
    field :is_published_until, :boolean, default: false
    field :is_verified, :boolean, default: false
    field :latitude, :float
    field :location_id, :integer
    field :longitude, :float
    field :modified, :utc_datetime
    field :name, :string
    field :opening_hours, :string
    field :price, :float
    field :published_until, :utc_datetime
    field :slug, :string
    field :type, :string
    field :user_id, :integer
    field :video_youtube, :string

    timestamps()
  end

  @doc false
  def changeset(listing, attrs) do
    listing
    |> cast(attrs, [:user_id, :category_id, :location_id, :name, :type, :slug, :description, :address, :price, :latitude, :longitude, :video_youtube, :opening_hours, :is_verified, :is_featured, :featured_until, :is_published_until, :published_until, :created, :modified])
    |> validate_required([:user_id, :category_id, :location_id, :name, :type, :slug, :description, :address, :price, :latitude, :longitude, :video_youtube, :opening_hours, :is_verified, :is_featured, :featured_until, :is_published_until, :published_until, :created, :modified])
  end
end
