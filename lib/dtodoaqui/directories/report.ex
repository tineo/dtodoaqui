defmodule Dtodoaqui.Directories.Report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field :is_approved, :boolean, default: false
    field :listing_id, :integer
    field :message, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:user_id, :listing_id, :message, :is_approved])
    |> validate_required([:user_id, :listing_id, :message, :is_approved])
  end
end
