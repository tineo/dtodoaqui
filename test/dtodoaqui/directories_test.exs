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
end
