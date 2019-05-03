defmodule Dtodoaqui.Resources.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :created, :utc_datetime
    field :image_name, :string
    field :listing_id, :integer
    field :modified, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:listing_id, :image_name, :created, :modified])
    |> validate_required([:listing_id, :image_name, :created, :modified])
  end
end
