defmodule DtodoaquiWeb.ImageView do
  use DtodoaquiWeb, :view
  alias DtodoaquiWeb.ImageView

  def render("index.json", %{images: images}) do
    %{data: render_many(images, ImageView, "image.json")}
  end

  def render("show.json", %{image: image}) do
    %{data: render_one(image, ImageView, "image.json")}
  end

  def render("image.json", %{image: image}) do
    %{id: image.id,
      listing_id: image.listing_id,
      image_name: image.image_name,
      created: image.created,
      modified: image.modified}
  end
end
