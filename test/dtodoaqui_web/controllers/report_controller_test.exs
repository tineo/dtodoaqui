defmodule DtodoaquiWeb.ReportControllerTest do
  use DtodoaquiWeb.ConnCase

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Report

  @create_attrs %{
    is_approved: true,
    listing_id: 42,
    message: "some message",
    user_id: 42
  }
  @update_attrs %{
    is_approved: false,
    listing_id: 43,
    message: "some updated message",
    user_id: 43
  }
  @invalid_attrs %{is_approved: nil, listing_id: nil, message: nil, user_id: nil}

  def fixture(:report) do
    {:ok, report} = Directories.create_report(@create_attrs)
    report
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all reports", %{conn: conn} do
      conn = get(conn, Routes.report_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create report" do
    test "renders report when data is valid", %{conn: conn} do
      conn = post(conn, Routes.report_path(conn, :create), report: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.report_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_approved" => true,
               "listing_id" => 42,
               "message" => "some message",
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.report_path(conn, :create), report: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update report" do
    setup [:create_report]

    test "renders report when data is valid", %{conn: conn, report: %Report{id: id} = report} do
      conn = put(conn, Routes.report_path(conn, :update, report), report: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.report_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_approved" => false,
               "listing_id" => 43,
               "message" => "some updated message",
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, report: report} do
      conn = put(conn, Routes.report_path(conn, :update, report), report: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete report" do
    setup [:create_report]

    test "deletes chosen report", %{conn: conn, report: report} do
      conn = delete(conn, Routes.report_path(conn, :delete, report))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.report_path(conn, :show, report))
      end
    end
  end

  defp create_report(_) do
    report = fixture(:report)
    {:ok, report: report}
  end
end
