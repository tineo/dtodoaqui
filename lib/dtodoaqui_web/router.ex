defmodule DtodoaquiWeb.Router do
  use DtodoaquiWeb, :router

  alias Dtodoaqui.Guardian

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
            schema: DtodoaquiWeb.Schema,
            interface: :simple,
            context: %{pubsub: DtodoaquiWeb.Endpoint}
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/", DtodoaquiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", DtodoaquiWeb do
  #   pipe_through :api
  # end

  scope "/api", DtodoaquiWeb do
    pipe_through :api
    #  GET      /api/users           DtodoaquiWeb.UserController :index
    #  GET      /api/users/:id/edit  DtodoaquiWeb.UserController :edit
    #  GET      /api/users/new       DtodoaquiWeb.UserController :new
    #  GET      /api/users/:id       DtodoaquiWeb.UserController :show
    #  POST     /api/users           DtodoaquiWeb.UserController :create
    #  PATCH    /api/users/:id       DtodoaquiWeb.UserController :update
    #  PUT      /api/users/:id       DtodoaquiWeb.UserController :update
    #  DELETE   /api/users/:id       DtodoaquiWeb.UserController :delete
    resources "/users", UserController, only: [:index, :create, :show, :update, :delete]
    options   "/users", UserController, :options
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in

    resources "/location", LocationController, only: [:index, :create, :show, :update, :delete]
    options   "/location", LocationController, :options

    get "/search", LocationController, :search

    resources "/profile", ProfileController, only: [:index, :create, :show, :update, :delete]
    options   "/profile", ProfileController, :options

    resources "/categories", CategoryController, only: [:index, :create, :show, :update, :delete]
    options   "/categories", CategoryController, :options

    resources "/reviews", ReviewController, only: [:index, :create, :show, :update, :delete]
    options   "/reviews", ReviewController, :options

    resources "/ratings", RatingController, only: [:index, :create, :show, :update, :delete]
    options   "/ratings", RatingController, :options

    resources "/images", ImageController, only: [:index, :create, :show, :update, :delete]
    options   "/images", ImageController, :options

    resources "/listings", ListingController, only: [:index, :create, :show, :update, :delete]
    options   "/listings", ListingController, :options


    #forward "/graphiql", Absinthe.Plug.GraphiQL,
    #        schema: DtodoaquiWeb.Schema.Schema,
    #        interface: :simple,
    #        context: %{pubsub: DtodoaquiWeb.Endpoint}
  end

  scope "/api", DtodoaquiWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/my_profile", ProfileController, :show_profile_jwt
    post "/my_profile", ProfileController, :create_profile_jwt
    put "/my_profile", ProfileController, :update_profile_jwt
    get "/my_user", UserController, :show_user_jwt
    get "/my_locations", LocationController, :show_locations_jwt
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :dtodoaqui, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Dtodoaqui"
      }
    }
  end


end
