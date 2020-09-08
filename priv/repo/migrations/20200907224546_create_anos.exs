defmodule FipeCrawler.Repo.Migrations.CreateAnos do
  use Ecto.Migration

  def change do
    create table(:anos, primary_key: false) do
      add :ano, :string
      add :valor, :integer
      add :combustivel, :string
      add :codigo_fipe, :string, primary_key: true
      add :modelo_id, references(:modelos)
    end
  end
end
