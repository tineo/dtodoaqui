defmodule DtodoaquiWeb.Schema do
  use Absinthe.Schema
  import_types(DtodoaquiWeb.Schema.Types)


  query do
    @desc "Get a list of users"
    field :users, list_of(:user) do
      resolve &DtodoaquiWeb.Resolvers.Accounts.users/3
    end

    @desc "Get a place by its id"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &DtodoaquiWeb.Resolvers.Accounts.user/3
    end
  end

  mutation do
    field :create_user, :user do
      arg :username, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :password_confirmation, non_null(:string)

      resolve &DtodoaquiWeb.Resolvers.Accounts.create_users/3
    end
  end

end