defmodule Dtodoaqui.DirectoriesTest do
  use Dtodoaqui.DataCase

  alias Dtodoaqui.Directories

  describe "locations" do
    alias Dtodoaqui.Directories.Location

    @valid_attrs %{created: "2010-04-17T14:00:00Z", image_name: "some image_name", is_verified: true, location_id: 42, modified: "2010-04-17T14:00:00Z", name: "some name", slug: "some slug"}
    @update_attrs %{created: "2011-05-18T15:01:01Z", image_name: "some updated image_name", is_verified: false, location_id: 43, modified: "2011-05-18T15:01:01Z", name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{created: nil, image_name: nil, is_verified: nil, location_id: nil, modified: nil, name: nil, slug: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directories.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Directories.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Directories.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Directories.create_location(@valid_attrs)
      assert location.created == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert location.image_name == "some image_name"
      assert location.is_verified == true
      assert location.location_id == 42
      assert location.modified == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert location.name == "some name"
      assert location.slug == "some slug"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directories.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, %Location{} = location} = Directories.update_location(location, @update_attrs)
      assert location.created == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert location.image_name == "some updated image_name"
      assert location.is_verified == false
      assert location.location_id == 43
      assert location.modified == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert location.name == "some updated name"
      assert location.slug == "some updated slug"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Directories.update_location(location, @invalid_attrs)
      assert location == Directories.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Directories.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Directories.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Directories.change_location(location)
    end
  end

  describe "listings" do
    alias Dtodoaqui.Directories.Listing

    @valid_attrs %{address: "some address", category_id: 42, created: "2010-04-17T14:00:00Z", description: "some description", featured_until: "2010-04-17T14:00:00Z", is_featured: true, is_published_until: true, is_verified: true, latitude: 120.5, location_id: 42, longitude: 120.5, modified: "2010-04-17T14:00:00Z", name: "some name", opening_hours: "some opening_hours", price: 120.5, published_until: "2010-04-17T14:00:00Z", slug: "some slug", type: "some type", user_id: 42, video_youtube: "some video_youtube"}
    @update_attrs %{address: "some updated address", category_id: 43, created: "2011-05-18T15:01:01Z", description: "some updated description", featured_until: "2011-05-18T15:01:01Z", is_featured: false, is_published_until: false, is_verified: false, latitude: 456.7, location_id: 43, longitude: 456.7, modified: "2011-05-18T15:01:01Z", name: "some updated name", opening_hours: "some updated opening_hours", price: 456.7, published_until: "2011-05-18T15:01:01Z", slug: "some updated slug", type: "some updated type", user_id: 43, video_youtube: "some updated video_youtube"}
    @invalid_attrs %{address: nil, category_id: nil, created: nil, description: nil, featured_until: nil, is_featured: nil, is_published_until: nil, is_verified: nil, latitude: nil, location_id: nil, longitude: nil, modified: nil, name: nil, opening_hours: nil, price: nil, published_until: nil, slug: nil, type: nil, user_id: nil, video_youtube: nil}

    def listing_fixture(attrs \\ %{}) do
      {:ok, listing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directories.create_listing()

      listing
    end

    test "list_listings/0 returns all listings" do
      listing = listing_fixture()
      assert Directories.list_listings() == [listing]
    end

    test "get_listing!/1 returns the listing with given id" do
      listing = listing_fixture()
      assert Directories.get_listing!(listing.id) == listing
    end

    test "create_listing/1 with valid data creates a listing" do
      assert {:ok, %Listing{} = listing} = Directories.create_listing(@valid_attrs)
      assert listing.address == "some address"
      assert listing.category_id == 42
      assert listing.created == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert listing.description == "some description"
      assert listing.featured_until == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert listing.is_featured == true
      assert listing.is_published_until == true
      assert listing.is_verified == true
      assert listing.latitude == 120.5
      assert listing.location_id == 42
      assert listing.longitude == 120.5
      assert listing.modified == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert listing.name == "some name"
      assert listing.opening_hours == "some opening_hours"
      assert listing.price == 120.5
      assert listing.published_until == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert listing.slug == "some slug"
      assert listing.type == "some type"
      assert listing.user_id == 42
      assert listing.video_youtube == "some video_youtube"
    end

    test "create_listing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directories.create_listing(@invalid_attrs)
    end

    test "update_listing/2 with valid data updates the listing" do
      listing = listing_fixture()
      assert {:ok, %Listing{} = listing} = Directories.update_listing(listing, @update_attrs)
      assert listing.address == "some updated address"
      assert listing.category_id == 43
      assert listing.created == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert listing.description == "some updated description"
      assert listing.featured_until == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert listing.is_featured == false
      assert listing.is_published_until == false
      assert listing.is_verified == false
      assert listing.latitude == 456.7
      assert listing.location_id == 43
      assert listing.longitude == 456.7
      assert listing.modified == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert listing.name == "some updated name"
      assert listing.opening_hours == "some updated opening_hours"
      assert listing.price == 456.7
      assert listing.published_until == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert listing.slug == "some updated slug"
      assert listing.type == "some updated type"
      assert listing.user_id == 43
      assert listing.video_youtube == "some updated video_youtube"
    end

    test "update_listing/2 with invalid data returns error changeset" do
      listing = listing_fixture()
      assert {:error, %Ecto.Changeset{}} = Directories.update_listing(listing, @invalid_attrs)
      assert listing == Directories.get_listing!(listing.id)
    end

    test "delete_listing/1 deletes the listing" do
      listing = listing_fixture()
      assert {:ok, %Listing{}} = Directories.delete_listing(listing)
      assert_raise Ecto.NoResultsError, fn -> Directories.get_listing!(listing.id) end
    end

    test "change_listing/1 returns a listing changeset" do
      listing = listing_fixture()
      assert %Ecto.Changeset{} = Directories.change_listing(listing)
    end
  end

  describe "fields" do
    alias Dtodoaqui.Directories.Field

    @valid_attrs %{created: "2010-04-17T14:00:00Z", data_key: "some data_key", data_value: "some data_value", listing_id: 42, modified: "2010-04-17T14:00:00Z"}
    @update_attrs %{created: "2011-05-18T15:01:01Z", data_key: "some updated data_key", data_value: "some updated data_value", listing_id: 43, modified: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{created: nil, data_key: nil, data_value: nil, listing_id: nil, modified: nil}

    def field_fixture(attrs \\ %{}) do
      {:ok, field} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directories.create_field()

      field
    end

    test "list_fields/0 returns all fields" do
      field = field_fixture()
      assert Directories.list_fields() == [field]
    end

    test "get_field!/1 returns the field with given id" do
      field = field_fixture()
      assert Directories.get_field!(field.id) == field
    end

    test "create_field/1 with valid data creates a field" do
      assert {:ok, %Field{} = field} = Directories.create_field(@valid_attrs)
      assert field.created == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert field.data_key == "some data_key"
      assert field.data_value == "some data_value"
      assert field.listing_id == 42
      assert field.modified == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_field/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directories.create_field(@invalid_attrs)
    end

    test "update_field/2 with valid data updates the field" do
      field = field_fixture()
      assert {:ok, %Field{} = field} = Directories.update_field(field, @update_attrs)
      assert field.created == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert field.data_key == "some updated data_key"
      assert field.data_value == "some updated data_value"
      assert field.listing_id == 43
      assert field.modified == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_field/2 with invalid data returns error changeset" do
      field = field_fixture()
      assert {:error, %Ecto.Changeset{}} = Directories.update_field(field, @invalid_attrs)
      assert field == Directories.get_field!(field.id)
    end

    test "delete_field/1 deletes the field" do
      field = field_fixture()
      assert {:ok, %Field{}} = Directories.delete_field(field)
      assert_raise Ecto.NoResultsError, fn -> Directories.get_field!(field.id) end
    end

    test "change_field/1 returns a field changeset" do
      field = field_fixture()
      assert %Ecto.Changeset{} = Directories.change_field(field)
    end
  end
end
