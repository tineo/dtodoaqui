defmodule DtodoaquiWeb.ImageController do
  use DtodoaquiWeb, :controller

  alias Dtodoaqui.Resources
  alias Dtodoaqui.Resources.Image

  action_fallback DtodoaquiWeb.FallbackController

  def index(conn, _params) do
    images = Resources.list_images()
    render(conn, "index.json", images: images)
  end

  def create(conn, %{"image" => image_params}) do
    with {:ok, %Image{} = image} <- Resources.create_image(image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.image_path(conn, :show, image))
      |> render("show.json", image: image)
    end
  end

  def create_image_jwt(conn, %{"image" => image_params}) do
    user = Guardian.Plug.current_resource(conn)
    image_params = Map.put(image_params, "user_id", user.id)
    with {:ok, %Image{} = image} <- Resources.create_image(image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.image_path(conn, :show, image))
      |> render("show.json", image: image)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Resources.get_image!(id)
    render(conn, "show.json", image: image)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Resources.get_image!(id)

    with {:ok, %Image{} = image} <- Resources.update_image(image, image_params) do
      render(conn, "show.json", image: image)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Resources.get_image!(id)

    with {:ok, %Image{}} <- Resources.delete_image(image) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_images(conn, %{"id" => id} ) do
    images = Resources.list_images_by_listing!(id)
    render(conn, "index.json", images: images)
  end
end
