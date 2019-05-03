defmodule Dtodoaqui.AccountsTest do
  use Dtodoaqui.DataCase

  alias Dtodoaqui.Accounts

  describe "directory_platform_users" do
    alias Dtodoaqui.Accounts.User

    @valid_attrs %{confirmation_token: "some confirmation_token", created: "2010-04-17T14:00:00Z", email: "some email", email_canonical: "some email_canonical", enabled: true, is_verified: true, last_login: "2010-04-17T14:00:00Z", modified: "2010-04-17T14:00:00Z", password: "some password", password_requested_at: "2010-04-17T14:00:00Z", roles: "some roles", salt: "some salt", username: "some username", username_canonical: "some username_canonical"}
    @update_attrs %{confirmation_token: "some updated confirmation_token", created: "2011-05-18T15:01:01Z", email: "some updated email", email_canonical: "some updated email_canonical", enabled: false, is_verified: false, last_login: "2011-05-18T15:01:01Z", modified: "2011-05-18T15:01:01Z", password: "some updated password", password_requested_at: "2011-05-18T15:01:01Z", roles: "some updated roles", salt: "some updated salt", username: "some updated username", username_canonical: "some updated username_canonical"}
    @invalid_attrs %{confirmation_token: nil, created: nil, email: nil, email_canonical: nil, enabled: nil, is_verified: nil, last_login: nil, modified: nil, password: nil, password_requested_at: nil, roles: nil, salt: nil, username: nil, username_canonical: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_directory_platform_users/0 returns all directory_platform_users" do
      user = user_fixture()
      assert Accounts.list_directory_platform_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.confirmation_token == "some confirmation_token"
      assert user.created == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert user.email == "some email"
      assert user.email_canonical == "some email_canonical"
      assert user.enabled == true
      assert user.is_verified == true
      assert user.last_login == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert user.modified == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert user.password == "some password"
      assert user.password_requested_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert user.roles == "some roles"
      assert user.salt == "some salt"
      assert user.username == "some username"
      assert user.username_canonical == "some username_canonical"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.confirmation_token == "some updated confirmation_token"
      assert user.created == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert user.email == "some updated email"
      assert user.email_canonical == "some updated email_canonical"
      assert user.enabled == false
      assert user.is_verified == false
      assert user.last_login == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert user.modified == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert user.password == "some updated password"
      assert user.password_requested_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert user.roles == "some updated roles"
      assert user.salt == "some updated salt"
      assert user.username == "some updated username"
      assert user.username_canonical == "some updated username_canonical"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "profiles" do
    alias Dtodoaqui.Accounts.Profile

    @valid_attrs %{address: "some address", avatar_name: "some avatar_name", country: "some country", created: "2010-04-17T14:00:00Z", description: "some description", facebook: "some facebook", first_name: "some first_name", last_name: "some last_name", linkedin: "some linkedin", modified: "2010-04-17T14:00:00Z", phone: "some phone", twitter: "some twitter", user_id: 42, website: "some website"}
    @update_attrs %{address: "some updated address", avatar_name: "some updated avatar_name", country: "some updated country", created: "2011-05-18T15:01:01Z", description: "some updated description", facebook: "some updated facebook", first_name: "some updated first_name", last_name: "some updated last_name", linkedin: "some updated linkedin", modified: "2011-05-18T15:01:01Z", phone: "some updated phone", twitter: "some updated twitter", user_id: 43, website: "some updated website"}
    @invalid_attrs %{address: nil, avatar_name: nil, country: nil, created: nil, description: nil, facebook: nil, first_name: nil, last_name: nil, linkedin: nil, modified: nil, phone: nil, twitter: nil, user_id: nil, website: nil}

    def profile_fixture(attrs \\ %{}) do
      {:ok, profile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_profile()

      profile
    end

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Accounts.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Accounts.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      assert {:ok, %Profile{} = profile} = Accounts.create_profile(@valid_attrs)
      assert profile.address == "some address"
      assert profile.avatar_name == "some avatar_name"
      assert profile.country == "some country"
      assert profile.created == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert profile.description == "some description"
      assert profile.facebook == "some facebook"
      assert profile.first_name == "some first_name"
      assert profile.last_name == "some last_name"
      assert profile.linkedin == "some linkedin"
      assert profile.modified == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert profile.phone == "some phone"
      assert profile.twitter == "some twitter"
      assert profile.user_id == 42
      assert profile.website == "some website"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{} = profile} = Accounts.update_profile(profile, @update_attrs)
      assert profile.address == "some updated address"
      assert profile.avatar_name == "some updated avatar_name"
      assert profile.country == "some updated country"
      assert profile.created == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert profile.description == "some updated description"
      assert profile.facebook == "some updated facebook"
      assert profile.first_name == "some updated first_name"
      assert profile.last_name == "some updated last_name"
      assert profile.linkedin == "some updated linkedin"
      assert profile.modified == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert profile.phone == "some updated phone"
      assert profile.twitter == "some updated twitter"
      assert profile.user_id == 43
      assert profile.website == "some updated website"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_profile(profile, @invalid_attrs)
      assert profile == Accounts.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Accounts.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Accounts.change_profile(profile)
    end
  end
end
