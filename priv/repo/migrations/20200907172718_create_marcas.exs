defmodule FipeCrawler.Repo.Migrations.CreateMarcas do
  use Ecto.Migration

  def change do
    create table(:marcas) do
      add :nome, :string
    end
  end
end
