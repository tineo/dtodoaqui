defmodule DtodoaquiWeb.ListingView do
  use DtodoaquiWeb, :view
  alias DtodoaquiWeb.ListingView

  def render("index.json", %{listings: listings}) do
    %{data: render_many(listings, ListingView, "listing.json")}
  end

  def render("show.json", %{listing: listing}) do
    %{data: render_one(listing, ListingView, "listing.json")}
  end

  def render("listing.json", %{listing: listing}) do
    %{id: listing.id,
      user_id: listing.user_id,
      category_id: listing.category_id,
      location_id: listing.location_id,
      name: listing.name,
      type: listing.type,
      slug: listing.slug,
      description: listing.description,
      address: listing.address,
      price: listing.price,
      latitude: listing.latitude,
      longitude: listing.longitude,
      video_youtube: listing.video_youtube,
      opening_hours: listing.opening_hours,
      is_verified: listing.is_verified,
      is_featured: listing.is_featured,
      featured_until: listing.featured_until,
      is_published_until: listing.is_published_until,
      published_until: listing.published_until,
      created: listing.created,
      modified: listing.modified}
  end
end
