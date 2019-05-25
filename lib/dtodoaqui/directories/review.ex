defmodule Dtodoaqui.Directories.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :description, :string
    field :is_published, :boolean
    field :listing_id, :integer
    field :name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:user_id, :listing_id, :name, :description, :is_published])
    |> validate_required([:user_id, :listing_id, :name, :description, :is_published])
  end
end
