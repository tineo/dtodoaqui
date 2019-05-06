defmodule DtodoaquiWeb.FieldController do
  use DtodoaquiWeb, :controller

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Field

  action_fallback DtodoaquiWeb.FallbackController

  def index(conn, _params) do
    fields = Directories.list_fields()
    render(conn, "index.json", fields: fields)
  end

  def create(conn, %{"field" => field_params}) do
    with {:ok, %Field{} = field} <- Directories.create_field(field_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.field_path(conn, :show, field))
      |> render("show.json", field: field)
    end
  end

  def show(conn, %{"id" => id}) do
    field = Directories.get_field!(id)
    render(conn, "show.json", field: field)
  end

  def update(conn, %{"id" => id, "field" => field_params}) do
    field = Directories.get_field!(id)

    with {:ok, %Field{} = field} <- Directories.update_field(field, field_params) do
      render(conn, "show.json", field: field)
    end
  end

  def delete(conn, %{"id" => id}) do
    field = Directories.get_field!(id)

    with {:ok, %Field{}} <- Directories.delete_field(field) do
      send_resp(conn, :no_content, "")
    end
  end
end
