defmodule DtodoaquiWeb.ClaimController do
  use DtodoaquiWeb, :controller

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Claim

  action_fallback DtodoaquiWeb.FallbackController

  def index(conn, _params) do
    claims = Directories.list_claims()
    render(conn, "index.json", claims: claims)
  end

  def create(conn, %{"claim" => claim_params}) do
    with {:ok, %Claim{} = claim} <- Directories.create_claim(claim_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.claim_path(conn, :show, claim))
      |> render("show.json", claim: claim)
    end
  end

  def show(conn, %{"id" => id}) do
    claim = Directories.get_claim!(id)
    render(conn, "show.json", claim: claim)
  end

  def update(conn, %{"id" => id, "claim" => claim_params}) do
    claim = Directories.get_claim!(id)

    with {:ok, %Claim{} = claim} <- Directories.update_claim(claim, claim_params) do
      render(conn, "show.json", claim: claim)
    end
  end

  def delete(conn, %{"id" => id}) do
    claim = Directories.get_claim!(id)

    with {:ok, %Claim{}} <- Directories.delete_claim(claim) do
      send_resp(conn, :no_content, "")
    end
  end
end
