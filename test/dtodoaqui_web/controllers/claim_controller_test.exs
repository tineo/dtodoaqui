defmodule DtodoaquiWeb.ClaimControllerTest do
  use DtodoaquiWeb.ConnCase

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Claim

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

  def fixture(:claim) do
    {:ok, claim} = Directories.create_claim(@create_attrs)
    claim
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all claims", %{conn: conn} do
      conn = get(conn, Routes.claim_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create claim" do
    test "renders claim when data is valid", %{conn: conn} do
      conn = post(conn, Routes.claim_path(conn, :create), claim: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.claim_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_approved" => true,
               "listing_id" => 42,
               "message" => "some message",
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.claim_path(conn, :create), claim: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update claim" do
    setup [:create_claim]

    test "renders claim when data is valid", %{conn: conn, claim: %Claim{id: id} = claim} do
      conn = put(conn, Routes.claim_path(conn, :update, claim), claim: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.claim_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_approved" => false,
               "listing_id" => 43,
               "message" => "some updated message",
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, claim: claim} do
      conn = put(conn, Routes.claim_path(conn, :update, claim), claim: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete claim" do
    setup [:create_claim]

    test "deletes chosen claim", %{conn: conn, claim: claim} do
      conn = delete(conn, Routes.claim_path(conn, :delete, claim))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.claim_path(conn, :show, claim))
      end
    end
  end

  defp create_claim(_) do
    claim = fixture(:claim)
    {:ok, claim: claim}
  end
end
