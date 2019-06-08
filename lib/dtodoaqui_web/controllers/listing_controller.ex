defmodule DtodoaquiWeb.ListingController do
  use DtodoaquiWeb, :controller

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Listing

  action_fallback DtodoaquiWeb.FallbackController

  def index(conn, _params) do
    listings = Directories.list_listings()
    render(conn, "index.json", listings: listings)
  end

  def create(conn, %{"listing" => listing_params}) do
    with {:ok, %Listing{} = listing} <- Directories.create_listing(listing_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.listing_path(conn, :show, listing))
      |> render("show.json", listing: listing)
    end
  end

  def show(conn, %{"id" => id}) do
    listing = Directories.get_listing!(id)
    render(conn, "show.json", listing: listing)
  end

  def update(conn, %{"id" => id, "listing" => listing_params}) do
    listing = Directories.get_listing!(id)

    with {:ok, %Listing{} = listing} <- Directories.update_listing(listing, listing_params) do
      render(conn, "show.json", listing: listing)
    end
  end

  def delete(conn, %{"id" => id}) do
    listing = Directories.get_listing!(id)

    with {:ok, %Listing{}} <- Directories.delete_listing(listing) do
      send_resp(conn, :no_content, "")
    end
  end

  def search(conn, _params) do
    _params |> IO.inspect()
    keyword = case Map.has_key?(_params,"keyword") do
      true -> _params["keyword"]
      _ -> ""
    end
    _params = Map.put(_params, "keyword", keyword)
    _params["keyword"] |> IO.puts
    _params["categories"] |> IO.puts
    _params["location"] |> IO.puts
    _params["find_location"] |> IO.puts
    listings = Directories.search_listings(_params)
    render(conn, "index.json", listings: listings)
  end
end
