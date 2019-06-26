# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Dtodoaqui.Repo.insert!(%Dtodoaqui.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# locations
# field :image_name, :string
# field :is_verified, :boolean, default: false
# field :user_id, :integer
# field :name, :string
# field :district, :string
# field :address, :string
# field :slug, :string
# field :latitude, :decimal
# field :longitude, :decimal


Dtodoaqui.Repo.insert!(
  %Dtodoaqui.Directories.Location{
    image_name: "https://lh5.googleusercontent.com/p/AF1QipNMRWvi3j1GXKPrKXQKZyEUIvLQk_vZN_lzV-vD=w203-h152-k-no",
    user_id: 1,
    name: "San Martín de Porres",
    district: "San Martín de Porres",
    address: "San+Martín+de+Porres",
    slug: "smp",
    latitude: -11.9879112,
    longitude: -77.1554517
  })

Dtodoaqui.Repo.insert!(
  %Dtodoaqui.Directories.Location{
    image_name: "https://lh5.googleusercontent.com/p/AF1QipOb6rxu4lAO-FCCKiNsyyDD4UR0adUn7a7MBgBV=w408-h544-k-no",
    user_id: 1,
    name: "San Miguel",
    district: "San+Miguel",
    address: "San+Miguel",
    slug: "san-miguel",
    latitude: -12.0793143,
    longitude: -77.1092095
  })

Dtodoaqui.Repo.insert!(
  %Dtodoaqui.Directories.Location{
    image_name: "https://lh5.googleusercontent.com/p/AF1QipNMRWvi3j1GXKPrKXQKZyEUIvLQk_vZN_lzV-vD=w203-h152-k-no",
    user_id: 1,
    name: "Pueblo Libre",
    district: "Pueblo-Libre",
    address: "Pueblo+Libre",
    slug: "pueblo-libre",
    latitude: -12.076599,
    longitude: -77.083123
  })

Dtodoaqui.Repo.insert!(
  %Dtodoaqui.Directories.Location{
    image_name: "https://lh5.googleusercontent.com/p/AF1QipMsEahPLx8Sm9aVKBjev9nrW__7rOjxD5yygQhH=w408-h306-k-no",
    user_id: 1,
    name: "Lima District",
    district: "Lima District",
    address: "Lima+District",
    slug: "lima",
    latitude: -12.0552477,
    longitude: -77.0803283
  })


Dtodoaqui.Repo.insert!(
  %Dtodoaqui.Directories.Category{
    name: "Restaurants",
    slug: "restaurants",
    font_icon: "",
  })
Dtodoaqui.Repo.insert!(
  %Dtodoaqui.Directories.Category{
    name: "Comida Rapida",
    slug: "comida_rapida",
    font_icon: "",
  })
Dtodoaqui.Repo.insert!(
  %Dtodoaqui.Directories.Category{
    name: "Hoteles",
    slug: "hoteles",
    font_icon: "",
  })