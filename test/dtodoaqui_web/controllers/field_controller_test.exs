defmodule DtodoaquiWeb.FieldControllerTest do
  use DtodoaquiWeb.ConnCase

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Field

  @create_attrs %{
    created: "2010-04-17T14:00:00Z",
    data_key: "some data_key",
    data_value: "some data_value",
    listing_id: 42,
    modified: "2010-04-17T14:00:00Z"
  }
  @update_attrs %{
    created: "2011-05-18T15:01:01Z",
    data_key: "some updated data_key",
    data_value: "some updated data_value",
    listing_id: 43,
    modified: "2011-05-18T15:01:01Z"
  }
  @invalid_attrs %{created: nil, data_key: nil, data_value: nil, listing_id: nil, modified: nil}

  def fixture(:field) do
    {:ok, field} = Directories.create_field(@create_attrs)
    field
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all fields", %{conn: conn} do
      conn = get(conn, Routes.field_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create field" do
    test "renders field when data is valid", %{conn: conn} do
      conn = post(conn, Routes.field_path(conn, :create), field: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.field_path(conn, :show, id))

      assert %{
               "id" => id,
               "created" => "2010-04-17T14:00:00Z",
               "data_key" => "some data_key",
               "data_value" => "some data_value",
               "listing_id" => 42,
               "modified" => "2010-04-17T14:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.field_path(conn, :create), field: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update field" do
    setup [:create_field]

    test "renders field when data is valid", %{conn: conn, field: %Field{id: id} = field} do
      conn = put(conn, Routes.field_path(conn, :update, field), field: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.field_path(conn, :show, id))

      assert %{
               "id" => id,
               "created" => "2011-05-18T15:01:01Z",
               "data_key" => "some updated data_key",
               "data_value" => "some updated data_value",
               "listing_id" => 43,
               "modified" => "2011-05-18T15:01:01Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, field: field} do
      conn = put(conn, Routes.field_path(conn, :update, field), field: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete field" do
    setup [:create_field]

    test "deletes chosen field", %{conn: conn, field: field} do
      conn = delete(conn, Routes.field_path(conn, :delete, field))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.field_path(conn, :show, field))
      end
    end
  end

  defp create_field(_) do
    field = fixture(:field)
    {:ok, field: field}
  end
end
