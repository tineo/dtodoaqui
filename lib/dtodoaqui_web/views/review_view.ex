defmodule DtodoaquiWeb.ReviewView do
  use DtodoaquiWeb, :view
  alias DtodoaquiWeb.ReviewView

  def render("index.json", %{reviews: reviews}) do
    %{data: render_many(reviews, ReviewView, "review.json")}
  end

  def render("show.json", %{review: review}) do
    %{data: render_one(review, ReviewView, "review.json")}
  end

  def render("review.json", %{review: review}) do
    %{id: review.id,
      user_id: review.user_id,
      listing_id: review.listing_id,
      name: review.name,
      description: review.description,
      is_published: review.is_published}
  end
end
