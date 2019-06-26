defmodule Dtodoaqui.Directories do
  @moduledoc """
  The Directories context.
  """

  import Ecto.Query, warn: false
  alias Dtodoaqui.Repo

  alias Dtodoaqui.Directories.Location
  alias Dtodoaqui.Directories.Listing
  alias Dtodoaqui.Directories.Category
  alias Dtodoaqui.Accounts.User


  @doc """
  Returns the list of locations.

  ## Examples

      iex> search_locations()
      [%Location{}, ...]

  """
  def search_listings(_params) do
    _params["keyword"] |> IO.puts
    _params["categories"] |> IO.puts
    _params["location"] |> IO.puts
    _params["find_location"] |> IO.puts

    _key = case _params["keyword"] do
                  "" -> nil
                  _ ->  "%"<> _params["keyword"] <> "%"
                end

    _category_id = case _params["categories"] do
                  "" -> nil
                  _ -> _params["categories"]
                end

    _location_id = case _params["location"] do
                     "" -> nil
                     _ -> _params["location"]
                   end

    _find_location = case _params["find_location"] do
                      "" -> nil
                      nil -> nil
                      _ -> "%"<> _params["find_location"] <> "%"
                      end

    query = from l in Listing

    query = if is_nil(_key) do
              query
            else
              from l in query, where: like(l.name, ^_key) or like(l.description, ^_key) or like(l.address, ^_key)
            end


    query = if is_nil(_category_id) do
              query
            else
              from l in query, where: l.category_id == ^_category_id
            end

    query = if is_nil(_location_id) do
              query
            else
              from l in query, where: l.location_id == ^_location_id
            end

    query = if is_nil(_find_location) do
              query
            else
              from l in query,
              join: lc in Location,
              on: lc.id == l.location_id,
              where: like(lc.name, ^_find_location)
            end

    Repo.all(query)

  end

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{source: %Location{}}

  """
  def change_location(%Location{} = location) do
    Location.changeset(location, %{})
  end

  alias Dtodoaqui.Directories.Listing

  @doc """
  Returns the list of listings.

  ## Examples

      iex> list_listings()
      [%Listing{}, ...]

  """
  def list_listings do
    Repo.all(Listing)
  end

  @doc """
  Gets a single listing.

  Raises `Ecto.NoResultsError` if the Listing does not exist.

  ## Examples

      iex> get_listing!(123)
      %Listing{}

      iex> get_listing!(456)
      ** (Ecto.NoResultsError)

  """
  def get_listing!(id), do: Repo.get!(Listing, id)

  @doc """
  Creates a listing.

  ## Examples

      iex> create_listing(%{field: value})
      {:ok, %Listing{}}

      iex> create_listing(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_listing(attrs \\ %{}) do
    %Listing{}
    |> Listing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a listing.

  ## Examples

      iex> update_listing(listing, %{field: new_value})
      {:ok, %Listing{}}

      iex> update_listing(listing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_listing(%Listing{} = listing, attrs) do
    listing
    |> Listing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Listing.

  ## Examples

      iex> delete_listing(listing)
      {:ok, %Listing{}}

      iex> delete_listing(listing)
      {:error, %Ecto.Changeset{}}

  """
  def delete_listing(%Listing{} = listing) do
    Repo.delete(listing)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking listing changes.

  ## Examples

      iex> change_listing(listing)
      %Ecto.Changeset{source: %Listing{}}

  """
  def change_listing(%Listing{} = listing) do
    Listing.changeset(listing, %{})
  end

  alias Dtodoaqui.Directories.Field

  @doc """
  Returns the list of fields.

  ## Examples

      iex> list_fields()
      [%Field{}, ...]

  """
  def list_fields do
    Repo.all(Field)
  end

  @doc """
  Gets a single field.

  Raises `Ecto.NoResultsError` if the Field does not exist.

  ## Examples

      iex> get_field!(123)
      %Field{}

      iex> get_field!(456)
      ** (Ecto.NoResultsError)

  """
  def get_field!(id), do: Repo.get!(Field, id)

  @doc """
  Creates a field.

  ## Examples

      iex> create_field(%{field: value})
      {:ok, %Field{}}

      iex> create_field(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_field(attrs \\ %{}) do
    %Field{}
    |> Field.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a field.

  ## Examples

      iex> update_field(field, %{field: new_value})
      {:ok, %Field{}}

      iex> update_field(field, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_field(%Field{} = field, attrs) do
    field
    |> Field.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Field.

  ## Examples

      iex> delete_field(field)
      {:ok, %Field{}}

      iex> delete_field(field)
      {:error, %Ecto.Changeset{}}

  """
  def delete_field(%Field{} = field) do
    Repo.delete(field)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking field changes.

  ## Examples

      iex> change_field(field)
      %Ecto.Changeset{source: %Field{}}

  """
  def change_field(%Field{} = field) do
    Field.changeset(field, %{})
  end



  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  def get_locations_by!(user_id) do

    user_id |> IO.inspect
    query = from l in Location, where: l.user_id == ^user_id
    Repo.all(query)
    #Repo.get_by(Location, user_id: user_id)
  end

  alias Dtodoaqui.Directories.Review

  @doc """
  Returns the list of reviews.

  ## Examples

      iex> list_reviews()
      [%Review{}, ...]

  """
  def list_reviews do
    query = from r in Review,
                 join: u in User,
                 on: u.id == r.user_id,
                 select: {r, u.username}
    Repo.all(query) |> Enum.map( fn { review, username } -> review |> Map.put(:username,username) end)
  end


  def list_reviews_by_listing!(listing_id) do
    query = from r in Review,
                 join: u in User,
                 on: u.id == r.user_id,
                 where: r.listing_id == ^listing_id,
                 select: {r, u.username}
    Repo.all(query) |> Enum.map( fn { review, username } -> review |> Map.put(:username, username) end)
  end

  @doc """
  Gets a single review.

  Raises `Ecto.NoResultsError` if the Review does not exist.

  ## Examples

      iex> get_review!(123)
      %Review{}

      iex> get_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_review!(id) do
    query = from r in Review,
                 join: u in User,
                 on: u.id == r.user_id,
                 where: r.id == ^id,
                 select: {r, u.username}
    { review, username } = Repo.one(query)
    review |> Map.put(:username, username)
  end

  @doc """
  Creates a review.

  ## Examples

      iex> create_review(%{field: value})
      {:ok, %Review{}}

      iex> create_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review.

  ## Examples

      iex> update_review(review, %{field: new_value})
      {:ok, %Review{}}

      iex> update_review(review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Review.

  ## Examples

      iex> delete_review(review)
      {:ok, %Review{}}

      iex> delete_review(review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking review changes.

  ## Examples

      iex> change_review(review)
      %Ecto.Changeset{source: %Review{}}

  """
  def change_review(%Review{} = review) do
    Review.changeset(review, %{})
  end

  alias Dtodoaqui.Directories.Rating

  @doc """
  Returns the list of ratings.

  ## Examples

      iex> list_ratings()
      [%Rating{}, ...]

  """
  def list_ratings do
    query = from r in Rating,
                 join: u in User,
                 select: {r, u.username}
    Repo.all(query) |> Enum.map( fn { ratings, username } -> ratings |> Map.put(:username, username) end)

  end

  @doc """
  Gets a single rating.

  Raises `Ecto.NoResultsError` if the Rating does not exist.

  ## Examples

      iex> get_rating!(123)
      %Rating{}

      iex> get_rating!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rating!(id) do
    query = from r in Rating,
                 join: u in User,
                 on: u.id == r.user_id,
                 where: r.id == ^id,
                 select: {r, u.username}
    { rating, username } = Repo.one(query)
    rating |> Map.put(:username, username)
  end

  def get_rating_by_listing!(listing_id) do
    query = from r in Rating,
                 where: r.type == "listing" and r.review_id == ^listing_id,
                 select: { sum(r.value), sum(r.max) }
    Repo.all(query) |> IO.inspect()
    #|> Enum.map( fn { review, username } -> review |> Map.put(:username, username) end)
  end

  @doc """
  Creates a rating.

  ## Examples

      iex> create_rating(%{field: value})
      {:ok, %Rating{}}

      iex> create_rating(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rating(attrs \\ %{}) do
    %Rating{}
    |> Rating.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rating.

  ## Examples

      iex> update_rating(rating, %{field: new_value})
      {:ok, %Rating{}}

      iex> update_rating(rating, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rating(%Rating{} = rating, attrs) do
    rating
    |> Rating.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Rating.

  ## Examples

      iex> delete_rating(rating)
      {:ok, %Rating{}}

      iex> delete_rating(rating)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rating(%Rating{} = rating) do
    Repo.delete(rating)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rating changes.

  ## Examples

      iex> change_rating(rating)
      %Ecto.Changeset{source: %Rating{}}

  """
  def change_rating(%Rating{} = rating) do
    Rating.changeset(rating, %{})
  end
end
