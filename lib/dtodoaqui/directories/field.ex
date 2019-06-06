defmodule Dtodoaqui.Directories.Field do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fields" do
    field :data_key, :string
    field :data_value, :string
    field :listing_id, :integer

    timestamps()
  end

  @doc false
  def changeset(field, attrs) do
    field
    |> cast(attrs, [:listing_id, :data_key, :data_value, :created, :modified])
    |> validate_required([:listing_id, :data_key, :data_value, :created, :modified])
  end
end
