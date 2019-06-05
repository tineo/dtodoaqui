defmodule DtodoaquiWeb.Resolvers.Accounts do
  alias Dtodoaqui.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def user(_, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
  end

  def create_users(_root, args, _info) do
    # TODO: add detailed error message handling later
    case Dtodoaqui.Accounts.create_user(args) do
      {:ok, user} ->
        {:ok, user}
      _error ->
        {:error, "could not create user"}
    end
  end
end