defmodule Dtodoaqui.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dtodoaqui.Accounts.User

  schema "users" do
    field :confirmation_token, :string, null: true
    field :email, :string
    field :email_canonical, :string, null: true
    field :enabled, :boolean, default: false
    field :is_verified, :boolean, default: false
    field :last_login, :utc_datetime, null: true
    field :password, :string
    # Virtual fields:
    field :password_confirmation, :string, virtual: true
    field :password_requested_at, :utc_datetime, null: true
    field :roles, :string, null: true
    field :salt, :string, null: true
    field :username, :string
    field :username_canonical, :string, null: true

    timestamps()
  end

  #@doc false
  #def changeset(user, attrs) do
  #  user
  #  |> cast(attrs, [:username, :username_canonical, :email, :email_canonical, :enabled, :salt, :password, :last_login, :confirmation_token, :password_requested_at, :roles, :is_verified, :created, :modified])
  #  |> validate_required([:username, :username_canonical, :email, :email_canonical, :enabled, :salt, :password, :last_login, :confirmation_token, :password_requested_at, :roles, :is_verified, :created, :modified])
  #end
  @doc false
  def changeset(%User{} = user, attrs) do
    IO.inspect(attrs)
    IO.inspect(Map.has_key?(attrs, :password_confirmation))
    IO.inspect(Map.keys(attrs))

    #case Map.has_key?(attrs, :password_confirmation) do
    #  true ->
          user
              |> cast(attrs, [:username, :email, :password, :password_confirmation, :roles]) # Remove hash, add pw + pw confirmation
              |> validate_required([:username, :email, :password, :password_confirmation]) # Remove hash, add pw + pw confirmation
              |> validate_format(:email, ~r/@/) # Check that email is valid
              |> validate_length(:password, min: 6) # Check that password length is >= 8
              |> validate_confirmation(:password) # Check that password === password_confirmation
              |> unique_constraint(:email)
              |> put_password_hash
    #  _ -> user |> cast(attrs, [:is_verified, :last_login, :password_confirmation, :username])
    #end
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password,  Bcrypt.hash_pwd_salt(pass))
      _ ->
          changeset
    end
  end
end
