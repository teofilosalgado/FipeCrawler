defmodule FipeCrawler.Schema.Modelo do
  use Ecto.Schema

  schema "modelos" do
    field :nome, :string
    belongs_to :marca, FipeCrawler.Schema.Marca
    has_many :anos, FipeCrawler.Schema.Ano
  end
end
