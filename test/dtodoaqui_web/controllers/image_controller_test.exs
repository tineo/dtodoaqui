defmodule DtodoaquiWeb.ImageControllerTest do
  use DtodoaquiWeb.ConnCase

  alias Dtodoaqui.Resources
  alias Dtodoaqui.Resources.Image

  @create_attrs %{
    created: "2010-04-17T14:00:00Z",
    image_name: "some image_name",
    listing_id: 42,
    modified: "2010-04-17T14:00:00Z"
  }
  @update_attrs %{
    created: "2011-05-18T15:01:01Z",
    image_name: "some updated image_name",
    listing_id: 43,
    modified: "2011-05-18T15:01:01Z"
  }
  @invalid_attrs %{created: nil, image_name: nil, listing_id: nil, modified: nil}

  def fixture(:image) do
    {:ok, image} = Resources.create_image(@create_attrs)
    image
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all images", %{conn: conn} do
      conn = get(conn, Routes.image_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create image" do
    test "renders image when data is valid", %{conn: conn} do
      conn = post(conn, Routes.image_path(conn, :create), image: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.image_path(conn, :show, id))

      assert %{
               "id" => id,
               "created" => "2010-04-17T14:00:00Z",
               "image_name" => "some image_name",
               "listing_id" => 42,
               "modified" => "2010-04-17T14:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.image_path(conn, :create), image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update image" do
    setup [:create_image]

    test "renders image when data is valid", %{conn: conn, image: %Image{id: id} = image} do
      conn = put(conn, Routes.image_path(conn, :update, image), image: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.image_path(conn, :show, id))

      assert %{
               "id" => id,
               "created" => "2011-05-18T15:01:01Z",
               "image_name" => "some updated image_name",
               "listing_id" => 43,
               "modified" => "2011-05-18T15:01:01Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, image: image} do
      conn = put(conn, Routes.image_path(conn, :update, image), image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete image" do
    setup [:create_image]

    test "deletes chosen image", %{conn: conn, image: image} do
      conn = delete(conn, Routes.image_path(conn, :delete, image))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.image_path(conn, :show, image))
      end
    end
  end

  defp create_image(_) do
    image = fixture(:image)
    {:ok, image: image}
  end
end
