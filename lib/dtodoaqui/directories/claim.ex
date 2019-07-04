defmodule Dtodoaqui.Directories.Claim do
  use Ecto.Schema
  import Ecto.Changeset

  schema "claims" do
    field :is_approved, :boolean, default: false
    field :listing_id, :integer
    field :message, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(claim, attrs) do
    claim
    |> cast(attrs, [:user_id, :listing_id, :message, :is_approved])
    |> validate_required([:user_id, :listing_id, :message, :is_approved])
  end
end
