defmodule FipeCrawler.Repo.Migrations.CreateModelos do
  use Ecto.Migration

  def change do
    create table(:modelos) do
      add :nome, :string
      add :marca_id, references(:marcas)
    end
  end
end
