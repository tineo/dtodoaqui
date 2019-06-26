defmodule Dtodoaqui.Directories.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :max, :integer
    field :review_id, :integer
    field :type, :string
    field :value, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:review_id, :type, :value, :max, :user_id])
    |> validate_required([:review_id, :type, :value, :max])
  end
end
