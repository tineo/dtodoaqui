defmodule DtodoaquiWeb.LocationView do
  use DtodoaquiWeb, :view
  alias DtodoaquiWeb.LocationView

  def render("index.json", %{locations: locations}) do
    %{data: render_many(locations, LocationView, "location.json")}
  end

  def render("show.json", %{location: location}) do
    %{data: render_one(location, LocationView, "location.json")}
  end

  def render("location.json", %{location: location}) do
    %{id: location.id,
      user_id: location.location_id,
      image_name: location.image_name,
      name: location.name,
      slug: location.slug,
      is_verified: location.is_verified,
      created: location.created,
      modified: location.modified}
  end
end
