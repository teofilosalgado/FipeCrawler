defmodule FipeCrawler.Schema.Marca do
  use Ecto.Schema

  schema "marcas" do
    field :nome, :string
    has_many :modelos, FipeCrawler.Schema.Modelo
  end
end
