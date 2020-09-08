defmodule FipeCrawler.Schema.Ano do
  use Ecto.Schema

  @primary_key({:codigo_fipe, :string, []})
  schema "anos" do
    field :ano, :string
    field :valor, Money.Ecto.Amount.Type
    field :combustivel, :string
    belongs_to :modelo, FipeCrawler.Schema.Modelo
  end
end
