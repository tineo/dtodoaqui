defmodule DtodoaquiWeb.ProfileView do
  use DtodoaquiWeb, :view
  alias DtodoaquiWeb.ProfileView

  def render("index.json", %{profiles: profiles}) do
    %{data: render_many(profiles, ProfileView, "profile.json")}
  end

  def render("show.json", %{profile: profile}) do
    %{data: render_one(profile, ProfileView, "profile.json")}
  end

  def render("profile.json", %{profile: profile}) do
    %{id: profile.id,
      user_id: profile.user_id,
      avatar_name: profile.avatar_name,
      first_name: profile.first_name,
      last_name: profile.last_name,
      country: profile.country,
      address: profile.address,
      description: profile.description,
      phone: profile.phone,
      website: profile.website,
      facebook: profile.facebook,
      #twitter: profile.twitter,
      #linkedin: profile.linkedin
    }
  end

  def render("detail.json", %{detail: detail}) do
    %{ratings: detail.ratings,
      reviews: detail.reviews,
      listings: detail.listings}
  end
end
