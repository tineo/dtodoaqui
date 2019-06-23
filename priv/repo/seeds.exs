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


#Dtodoaqui.Repo.insert!(
#  %Dtodoaqui.Directories.Location{
#    image_name: "",
#    verified: true,
#    user_id: 1,
#    name: "",
#    district: "",
#    address: "",
#    slug: "",
#    latitude: "",
#    longitude: ""
#})