defmodule Dtodoaqui.Resources.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :image_name, :string
    field :image_base64, :string, virtual: true
    field :entity_id, :integer
    field :entity_name, :string

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    #IO.inspect(attrs)
    #IO.inspect(Map.fetch(attrs, "image_base64"))
    {:ok, image_base64 } = Map.fetch(attrs, "image_base64")
    #IO.inspect(Map.keys(attrs))
    #IO.inspect(Map.values(attrs))
    #IO.inspect(attrs[:image_base64])

    #{:ok, data} = Base.decode64(image_base64)
    image_uri = case Base.decode64(image_base64) do
      {:ok, data} -> Base.decode64(image_base64)
                     image_uri = data |> binary_to_images
      _ -> ""
    end
    #File.write("/home/tineo/Escritorio/img.jpg", data, [:binary])


    #|> IO.inspect

    #binary_to_upload(data, path)
    #File.cwd! <> "/priv/static/images" |> IO.inspect
    image
    |> cast(attrs, [:listing_id, :image_name])
    |> put_change(:image_name, image_uri)
    |> validate_required([:listing_id, :image_name])
    #|> base64_to_upload(:image_base64)
  end

  defp base64_to_upload(changeset, str) do
    IO.inspect(str)
    with {:ok, data} <- Base.decode64(str) do
      binary_to_upload(data)
    end
  end

  defp binary_to_upload(binary) do
    with {:ok, path} <- Plug.Upload.random_file("upload"),
         {:ok, file} <- File.open(path, [:write, :binary]),
         :ok <- IO.binwrite(file, binary),
         :ok <- File.close(file) do
      IO.inspect(path)
      %Plug.Upload{path: path}
    end
  end

  defp binary_to_images(binary) do
    uri =  "images/" <> Ecto.UUID.generate
    path = File.cwd! <> "/priv/static/" <> uri
    with {:ok, file} <- File.open(path, [:write, :binary]),
         :ok <- IO.binwrite(file, binary),
         :ok <- File.close(file) do
      IO.inspect(path)
      uri
      #%Plug.Upload{path: path}
    end
  end
end
