defmodule Dtodoaqui.ResourcesTest do
  use Dtodoaqui.DataCase

  alias Dtodoaqui.Resources

  describe "images" do
    alias Dtodoaqui.Resources.Image

    @valid_attrs %{created: "2010-04-17T14:00:00Z", image_name: "some image_name", listing_id: 42, modified: "2010-04-17T14:00:00Z"}
    @update_attrs %{created: "2011-05-18T15:01:01Z", image_name: "some updated image_name", listing_id: 43, modified: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{created: nil, image_name: nil, listing_id: nil, modified: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Resources.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Resources.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Resources.create_image(@valid_attrs)
      assert image.created == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert image.image_name == "some image_name"
      assert image.listing_id == 42
      assert image.modified == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, %Image{} = image} = Resources.update_image(image, @update_attrs)
      assert image.created == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert image.image_name == "some updated image_name"
      assert image.listing_id == 43
      assert image.modified == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_image(image, @invalid_attrs)
      assert image == Resources.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Resources.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Resources.change_image(image)
    end
  end
end
