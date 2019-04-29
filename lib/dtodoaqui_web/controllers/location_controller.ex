defmodule DtodoaquiWeb.LocationController do
  use DtodoaquiWeb, :controller

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Location

  action_fallback DtodoaquiWeb.FallbackController

  def index(conn, _params) do
    locations = Directories.list_locations()
    render(conn, "index.json", locations: locations)
  end

  def create(conn, %{"location" => location_params}) do
    with {:ok, %Location{} = location} <- Directories.create_location(location_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.location_path(conn, :show, location))
      |> render("show.json", location: location)
    end
  end

  def show(conn, %{"id" => id}) do
    location = Directories.get_location!(id)
    render(conn, "show.json", location: location)
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = Directories.get_location!(id)

    with {:ok, %Location{} = location} <- Directories.update_location(location, location_params) do
      render(conn, "show.json", location: location)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Directories.get_location!(id)

    with {:ok, %Location{}} <- Directories.delete_location(location) do
      send_resp(conn, :no_content, "")
    end
  end
end
