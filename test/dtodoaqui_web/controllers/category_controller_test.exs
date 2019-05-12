defmodule DtodoaquiWeb.CategoryControllerTest do
  use DtodoaquiWeb.ConnCase

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Category

  @create_attrs %{
    created: "2010-04-17T14:00:00Z",
    font_icon: "some font_icon",
    modified: "2010-04-17T14:00:00Z",
    name: "some name",
    slug: "some slug"
  }
  @update_attrs %{
    created: "2011-05-18T15:01:01Z",
    font_icon: "some updated font_icon",
    modified: "2011-05-18T15:01:01Z",
    name: "some updated name",
    slug: "some updated slug"
  }
  @invalid_attrs %{created: nil, font_icon: nil, modified: nil, name: nil, slug: nil}

  def fixture(:category) do
    {:ok, category} = Directories.create_category(@create_attrs)
    category
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all categories", %{conn: conn} do
      conn = get(conn, Routes.category_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create category" do
    test "renders category when data is valid", %{conn: conn} do
      conn = post(conn, Routes.category_path(conn, :create), category: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.category_path(conn, :show, id))

      assert %{
               "id" => id,
               "created" => "2010-04-17T14:00:00Z",
               "font_icon" => "some font_icon",
               "modified" => "2010-04-17T14:00:00Z",
               "name" => "some name",
               "slug" => "some slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.category_path(conn, :create), category: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update category" do
    setup [:create_category]

    test "renders category when data is valid", %{conn: conn, category: %Category{id: id} = category} do
      conn = put(conn, Routes.category_path(conn, :update, category), category: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.category_path(conn, :show, id))

      assert %{
               "id" => id,
               "created" => "2011-05-18T15:01:01Z",
               "font_icon" => "some updated font_icon",
               "modified" => "2011-05-18T15:01:01Z",
               "name" => "some updated name",
               "slug" => "some updated slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, category: category} do
      conn = put(conn, Routes.category_path(conn, :update, category), category: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete category" do
    setup [:create_category]

    test "deletes chosen category", %{conn: conn, category: category} do
      conn = delete(conn, Routes.category_path(conn, :delete, category))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.category_path(conn, :show, category))
      end
    end
  end

  defp create_category(_) do
    category = fixture(:category)
    {:ok, category: category}
  end
end
