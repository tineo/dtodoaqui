defmodule DtodoaquiWeb.ProfileController do
  use DtodoaquiWeb, :controller

  alias Dtodoaqui.Accounts
  alias Dtodoaqui.Accounts.Profile

  alias Dtodoaqui.Guardian

  action_fallback DtodoaquiWeb.FallbackController

  def index(conn, _params) do
    profiles = Accounts.list_profiles()
    render(conn, "index.json", profiles: profiles)
  end

  def create(conn, %{"profile" => profile_params}) do
    with {:ok, %Profile{} = profile} <- Accounts.create_profile(profile_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.profile_path(conn, :show, profile))
      |> render("show.json", profile: profile)
    end
  end

  def show(conn, %{"id" => id}) do
    profile = Accounts.get_profile!(id)
    render(conn, "show.json", profile: profile)
  end

  def show_profile_jwt(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    user |> IO.inspect
    user.id |> IO.inspect
    user_id = user.id
    profile = Accounts.get_profile_by!(user_id)
    profile |> IO.inspect
    case profile do
      nil -> send_resp(conn, :no_content, "")
      _ -> conn |> render("profile.json", profile: profile)
    end
  end

  def create_profile_jwt(conn, %{"profile" => profile_params}) do
    profile_params |> IO.inspect()
    user = Guardian.Plug.current_resource(conn)
    user |> IO.inspect
    user.id |> IO.inspect
    with {:ok, %Profile{} = profile} <- Accounts.create_profile(profile_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.profile_path(conn, :show, profile))
      |> render("show.json", profile: profile)
    end
  end

  def update(conn, %{"id" => id, "profile" => profile_params}) do
    profile = Accounts.get_profile!(id)

    with {:ok, %Profile{} = profile} <- Accounts.update_profile(profile, profile_params) do
      render(conn, "show.json", profile: profile)
    end
  end

  def delete(conn, %{"id" => id}) do
    profile = Accounts.get_profile!(id)

    with {:ok, %Profile{}} <- Accounts.delete_profile(profile) do
      send_resp(conn, :no_content, "")
    end
  end
end
