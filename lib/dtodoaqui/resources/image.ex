defmodule Dtodoaqui.Resources.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :image_name, :string
    field :image_base64, :string, virtual: true
    field :entity_id, :integer
    field :entity_name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    #IO.inspect(attrs)
    #IO.inspect(Map.fetch(attrs, "image_base64"))
    {:ok, image_base64 } = Map.fetch(attrs, "image_base64")
    image_base64 |> IO.inspect()
    "data:image/" <> raw = image_base64

    #"" |> IO.inspect()
    #"" |> IO.inspect()
    #raw |> IO.inspect()
    base = case raw do
      "jpg;base64," <> base64 -> %{ ext: "jpg", image: base64}
      "png;base64," <> base64 -> %{ ext: "png", image: base64}
      "gif;base64," <> base64 -> %{ ext: "gif", image: base64}
    end


    #IO.inspect(Map.keys(attrs))
    #IO.inspect(Map.values(attrs))
    #IO.inspect(attrs[:image_base64])

    #{:ok, data} = Base.decode64(image_base64)
    #base |> IO.inspect()
    #base.image |> IO.inspect()
    #base.ext |> IO.inspect()
    image_uri = case Base.decode64(base.image) do
      {:ok, data} -> Base.decode64(base.image)
                     image_uri = data |> binary_to_images(base.ext)
      _ -> "empty"
    end
    #File.write("/home/tineo/Escritorio/img.jpg", data, [:binary])


    #|> IO.inspect

    #binary_to_upload(data, path)
    #File.cwd! <> "/priv/static/images" |> IO.inspect
    image
    |> cast(attrs, [:entity_id, :entity_name])
    |> put_change(:image_name, image_uri <> "." <> base.ext)
    |> validate_required([:entity_id, :entity_name])
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

  defp binary_to_images(binary, ext) do
    uri =  "images/" <> Ecto.UUID.generate
    path = File.cwd! <> "/priv/static/" <> uri <> "." <> ext
    with {:ok, file} <- File.open(path, [:write, :binary]),
         :ok <- IO.binwrite(file, binary),
         :ok <- File.close(file) do
      IO.inspect(path)
      uri
      #%Plug.Upload{path: path}
    end
  end
end
