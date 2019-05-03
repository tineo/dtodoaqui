defmodule DtodoaquiWeb.ProfileControllerTest do
  use DtodoaquiWeb.ConnCase

  alias Dtodoaqui.Accounts
  alias Dtodoaqui.Accounts.Profile

  @create_attrs %{
    address: "some address",
    avatar_name: "some avatar_name",
    country: "some country",
    created: "2010-04-17T14:00:00Z",
    description: "some description",
    facebook: "some facebook",
    first_name: "some first_name",
    last_name: "some last_name",
    linkedin: "some linkedin",
    modified: "2010-04-17T14:00:00Z",
    phone: "some phone",
    twitter: "some twitter",
    user_id: 42,
    website: "some website"
  }
  @update_attrs %{
    address: "some updated address",
    avatar_name: "some updated avatar_name",
    country: "some updated country",
    created: "2011-05-18T15:01:01Z",
    description: "some updated description",
    facebook: "some updated facebook",
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    linkedin: "some updated linkedin",
    modified: "2011-05-18T15:01:01Z",
    phone: "some updated phone",
    twitter: "some updated twitter",
    user_id: 43,
    website: "some updated website"
  }
  @invalid_attrs %{address: nil, avatar_name: nil, country: nil, created: nil, description: nil, facebook: nil, first_name: nil, last_name: nil, linkedin: nil, modified: nil, phone: nil, twitter: nil, user_id: nil, website: nil}

  def fixture(:profile) do
    {:ok, profile} = Accounts.create_profile(@create_attrs)
    profile
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all profiles", %{conn: conn} do
      conn = get(conn, Routes.profile_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create profile" do
    test "renders profile when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profile_path(conn, :create), profile: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.profile_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "avatar_name" => "some avatar_name",
               "country" => "some country",
               "created" => "2010-04-17T14:00:00Z",
               "description" => "some description",
               "facebook" => "some facebook",
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "linkedin" => "some linkedin",
               "modified" => "2010-04-17T14:00:00Z",
               "phone" => "some phone",
               "twitter" => "some twitter",
               "user_id" => 42,
               "website" => "some website"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profile_path(conn, :create), profile: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update profile" do
    setup [:create_profile]

    test "renders profile when data is valid", %{conn: conn, profile: %Profile{id: id} = profile} do
      conn = put(conn, Routes.profile_path(conn, :update, profile), profile: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.profile_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some updated address",
               "avatar_name" => "some updated avatar_name",
               "country" => "some updated country",
               "created" => "2011-05-18T15:01:01Z",
               "description" => "some updated description",
               "facebook" => "some updated facebook",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "linkedin" => "some updated linkedin",
               "modified" => "2011-05-18T15:01:01Z",
               "phone" => "some updated phone",
               "twitter" => "some updated twitter",
               "user_id" => 43,
               "website" => "some updated website"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, profile: profile} do
      conn = put(conn, Routes.profile_path(conn, :update, profile), profile: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete profile" do
    setup [:create_profile]

    test "deletes chosen profile", %{conn: conn, profile: profile} do
      conn = delete(conn, Routes.profile_path(conn, :delete, profile))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.profile_path(conn, :show, profile))
      end
    end
  end

  defp create_profile(_) do
    profile = fixture(:profile)
    {:ok, profile: profile}
  end
end
