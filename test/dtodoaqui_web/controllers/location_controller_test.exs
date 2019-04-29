defmodule DtodoaquiWeb.LocationControllerTest do
  use DtodoaquiWeb.ConnCase

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Location

  @create_attrs %{
    created: "2010-04-17T14:00:00Z",
    image_name: "some image_name",
    is_verified: true,
    location_id: 42,
    modified: "2010-04-17T14:00:00Z",
    name: "some name",
    slug: "some slug"
  }
  @update_attrs %{
    created: "2011-05-18T15:01:01Z",
    image_name: "some updated image_name",
    is_verified: false,
    location_id: 43,
    modified: "2011-05-18T15:01:01Z",
    name: "some updated name",
    slug: "some updated slug"
  }
  @invalid_attrs %{created: nil, image_name: nil, is_verified: nil, location_id: nil, modified: nil, name: nil, slug: nil}

  def fixture(:location) do
    {:ok, location} = Directories.create_location(@create_attrs)
    location
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all locations", %{conn: conn} do
      conn = get(conn, Routes.location_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create location" do
    test "renders location when data is valid", %{conn: conn} do
      conn = post(conn, Routes.location_path(conn, :create), location: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.location_path(conn, :show, id))

      assert %{
               "id" => id,
               "created" => "2010-04-17T14:00:00Z",
               "image_name" => "some image_name",
               "is_verified" => true,
               "location_id" => 42,
               "modified" => "2010-04-17T14:00:00Z",
               "name" => "some name",
               "slug" => "some slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.location_path(conn, :create), location: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update location" do
    setup [:create_location]

    test "renders location when data is valid", %{conn: conn, location: %Location{id: id} = location} do
      conn = put(conn, Routes.location_path(conn, :update, location), location: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.location_path(conn, :show, id))

      assert %{
               "id" => id,
               "created" => "2011-05-18T15:01:01Z",
               "image_name" => "some updated image_name",
               "is_verified" => false,
               "location_id" => 43,
               "modified" => "2011-05-18T15:01:01Z",
               "name" => "some updated name",
               "slug" => "some updated slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, location: location} do
      conn = put(conn, Routes.location_path(conn, :update, location), location: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete location" do
    setup [:create_location]

    test "deletes chosen location", %{conn: conn, location: location} do
      conn = delete(conn, Routes.location_path(conn, :delete, location))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.location_path(conn, :show, location))
      end
    end
  end

  defp create_location(_) do
    location = fixture(:location)
    {:ok, location: location}
  end
end
