defmodule DtodoaquiWeb.RatingController do
  use DtodoaquiWeb, :controller

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Rating

  action_fallback DtodoaquiWeb.FallbackController

  def index(conn, _params) do
    ratings = Directories.list_ratings()
    render(conn, "index.json", ratings: ratings)
  end

  def create(conn, %{"rating" => rating_params}) do
    with {:ok, %Rating{} = rating} <- Directories.create_rating(rating_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.rating_path(conn, :show, rating))
      |> render("show.json", rating: rating)
    end
  end

  def show(conn, %{"id" => id}) do
    rating = Directories.get_rating!(id)
    render(conn, "show.json", rating: rating)
  end

  def update(conn, %{"id" => id, "rating" => rating_params}) do
    rating = Directories.get_rating!(id)

    with {:ok, %Rating{} = rating} <- Directories.update_rating(rating, rating_params) do
      render(conn, "show.json", rating: rating)
    end
  end

  def delete(conn, %{"id" => id}) do
    rating = Directories.get_rating!(id)

    with {:ok, %Rating{}} <- Directories.delete_rating(rating) do
      send_resp(conn, :no_content, "")
    end
  end
end
