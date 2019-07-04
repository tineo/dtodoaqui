defmodule DtodoaquiWeb.ClaimView do
  use DtodoaquiWeb, :view
  alias DtodoaquiWeb.ClaimView

  def render("index.json", %{claims: claims}) do
    %{data: render_many(claims, ClaimView, "claim.json")}
  end

  def render("show.json", %{claim: claim}) do
    %{data: render_one(claim, ClaimView, "claim.json")}
  end

  def render("claim.json", %{claim: claim}) do
    %{id: claim.id,
      user_id: claim.user_id,
      listing_id: claim.listing_id,
      message: claim.message,
      is_approved: claim.is_approved}
  end
end
