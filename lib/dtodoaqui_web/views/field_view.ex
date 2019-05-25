defmodule DtodoaquiWeb.FieldView do
  use DtodoaquiWeb, :view
  alias DtodoaquiWeb.FieldView

  def render("index.json", %{fields: fields}) do
    %{data: render_many(fields, FieldView, "field.json")}
  end

  def render("show.json", %{field: field}) do
    %{data: render_one(field, FieldView, "field.json")}
  end

  def render("field.json", %{field: field}) do
    %{id: field.id,
      listing_id: field.listing_id,
      data_key: field.data_key,
      data_value: field.data_value
    }
  end
end
