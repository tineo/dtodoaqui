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
      entity_id: image.entity_id,
      entity_name: image.entity_name,
      image_name: image.image_name
    }
  end
end
