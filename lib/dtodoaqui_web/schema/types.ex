defmodule DtodoaquiWeb.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Dtodoaqui.Repo


  object :user do
    field :id, non_null(:id)
    field :username, non_null(:string)
    field :email, non_null(:string)
    field :is_verified, non_null(:boolean)
    field :enable, non_null(:boolean)
  end

end