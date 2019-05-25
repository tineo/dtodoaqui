defmodule DtodoaquiWeb.ReviewController do
  use DtodoaquiWeb, :controller

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Review

  action_fallback DtodoaquiWeb.FallbackController

  def index(conn, _params) do
    reviews = Directories.list_reviews()
    render(conn, "index.json", reviews: reviews)
  end

  def create(conn, %{"review" => review_params}) do
    with {:ok, %Review{} = review} <- Directories.create_review(review_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.review_path(conn, :show, review))
      |> render("show.json", review: review)
    end
  end

  def show(conn, %{"id" => id}) do
    review = Directories.get_review!(id)
    render(conn, "show.json", review: review)
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = Directories.get_review!(id)

    with {:ok, %Review{} = review} <- Directories.update_review(review, review_params) do
      render(conn, "show.json", review: review)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = Directories.get_review!(id)

    with {:ok, %Review{}} <- Directories.delete_review(review) do
      send_resp(conn, :no_content, "")
    end
  end
end
