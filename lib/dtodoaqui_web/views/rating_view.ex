defmodule DtodoaquiWeb.RatingView do
  use DtodoaquiWeb, :view
  alias DtodoaquiWeb.RatingView

  def render("index.json", %{ratings: ratings}) do
    %{data: render_many(ratings, RatingView, "rating.json")}
  end

  def render("show.json", %{rating: rating}) do
    %{data: render_one(rating, RatingView, "rating.json")}
  end

  def render("rating.json", %{rating: rating}) do
    %{id: rating.id,
      review_id: rating.review_id,
      type: rating.type,
      value: rating.value,
      max: rating.max}
  end
end
