defmodule DtodoaquiWeb.ListingControllerTest do
  use DtodoaquiWeb.ConnCase

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Listing

  @create_attrs %{
    address: "some address",
    category_id: 42,
    created: "2010-04-17T14:00:00Z",
    description: "some description",
    featured_until: "2010-04-17T14:00:00Z",
    is_featured: true,
    is_published_until: true,
    is_verified: true,
    latitude: 120.5,
    location_id: 42,
    longitude: 120.5,
    modified: "2010-04-17T14:00:00Z",
    name: "some name",
    opening_hours: "some opening_hours",
    price: 120.5,
    published_until: "2010-04-17T14:00:00Z",
    slug: "some slug",
    type: "some type",
    user_id: 42,
    video_youtube: "some video_youtube"
  }
  @update_attrs %{
    address: "some updated address",
    category_id: 43,
    created: "2011-05-18T15:01:01Z",
    description: "some updated description",
    featured_until: "2011-05-18T15:01:01Z",
    is_featured: false,
    is_published_until: false,
    is_verified: false,
    latitude: 456.7,
    location_id: 43,
    longitude: 456.7,
    modified: "2011-05-18T15:01:01Z",
    name: "some updated name",
    opening_hours: "some updated opening_hours",
    price: 456.7,
    published_until: "2011-05-18T15:01:01Z",
    slug: "some updated slug",
    type: "some updated type",
    user_id: 43,
    video_youtube: "some updated video_youtube"
  }
  @invalid_attrs %{address: nil, category_id: nil, created: nil, description: nil, featured_until: nil, is_featured: nil, is_published_until: nil, is_verified: nil, latitude: nil, location_id: nil, longitude: nil, modified: nil, name: nil, opening_hours: nil, price: nil, published_until: nil, slug: nil, type: nil, user_id: nil, video_youtube: nil}

  def fixture(:listing) do
    {:ok, listing} = Directories.create_listing(@create_attrs)
    listing
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all listings", %{conn: conn} do
      conn = get(conn, Routes.listing_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create listing" do
    test "renders listing when data is valid", %{conn: conn} do
      conn = post(conn, Routes.listing_path(conn, :create), listing: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.listing_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "category_id" => 42,
               "created" => "2010-04-17T14:00:00Z",
               "description" => "some description",
               "featured_until" => "2010-04-17T14:00:00Z",
               "is_featured" => true,
               "is_published_until" => true,
               "is_verified" => true,
               "latitude" => 120.5,
               "location_id" => 42,
               "longitude" => 120.5,
               "modified" => "2010-04-17T14:00:00Z",
               "name" => "some name",
               "opening_hours" => "some opening_hours",
               "price" => 120.5,
               "published_until" => "2010-04-17T14:00:00Z",
               "slug" => "some slug",
               "type" => "some type",
               "user_id" => 42,
               "video_youtube" => "some video_youtube"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.listing_path(conn, :create), listing: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update listing" do
    setup [:create_listing]

    test "renders listing when data is valid", %{conn: conn, listing: %Listing{id: id} = listing} do
      conn = put(conn, Routes.listing_path(conn, :update, listing), listing: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.listing_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some updated address",
               "category_id" => 43,
               "created" => "2011-05-18T15:01:01Z",
               "description" => "some updated description",
               "featured_until" => "2011-05-18T15:01:01Z",
               "is_featured" => false,
               "is_published_until" => false,
               "is_verified" => false,
               "latitude" => 456.7,
               "location_id" => 43,
               "longitude" => 456.7,
               "modified" => "2011-05-18T15:01:01Z",
               "name" => "some updated name",
               "opening_hours" => "some updated opening_hours",
               "price" => 456.7,
               "published_until" => "2011-05-18T15:01:01Z",
               "slug" => "some updated slug",
               "type" => "some updated type",
               "user_id" => 43,
               "video_youtube" => "some updated video_youtube"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, listing: listing} do
      conn = put(conn, Routes.listing_path(conn, :update, listing), listing: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete listing" do
    setup [:create_listing]

    test "deletes chosen listing", %{conn: conn, listing: listing} do
      conn = delete(conn, Routes.listing_path(conn, :delete, listing))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.listing_path(conn, :show, listing))
      end
    end
  end

  defp create_listing(_) do
    listing = fixture(:listing)
    {:ok, listing: listing}
  end
end
